import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/ai/ai_config.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../domain/usecases/ai_usecases.dart';

/// Receipt OCR — scan with ML Kit and extract merchant, amount, date, category.
class ReceiptOcrPage extends StatefulWidget {
  const ReceiptOcrPage({super.key});

  @override
  State<ReceiptOcrPage> createState() => _ReceiptOcrPageState();
}

class _ReceiptOcrPageState extends State<ReceiptOcrPage> {
  final _textController = TextEditingController();
  final _picker = ImagePicker();
  bool _processing = false;
  String? _merchant;
  double? _amount;
  String? _category;
  DateTime? _date;
  double? _confidence;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _scan(ImageSource source) async {
    final image = await _picker.pickImage(
      source: source,
      imageQuality: 85,
    );
    if (image == null || !mounted) return;

    setState(() => _processing = true);
    final useCase = getIt<ParseReceiptImageUseCase>();
    final result = await useCase(image.path);
    if (!mounted) return;

    result.fold(
      (failure) {
        setState(() => _processing = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failure.message)),
        );
      },
      (receipt) {
        setState(() {
          _processing = false;
          _merchant = receipt.merchantName;
          _amount = receipt.amount;
          _category = receipt.category;
          _date = receipt.date;
          _confidence = receipt.confidence;
          _textController.text = receipt.rawText;
        });
      },
    );
  }

  Future<void> _parseManual() async {
    if (_textController.text.trim().isEmpty) return;
    setState(() => _processing = true);
    final result = await getIt<ParseReceiptUseCase>()(_textController.text);
    if (!mounted) return;

    result.fold(
      (failure) {
        setState(() => _processing = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failure.message)),
        );
      },
      (receipt) => setState(() {
        _processing = false;
        _merchant = receipt.merchantName;
        _amount = receipt.amount;
        _category = receipt.category;
        _date = receipt.date;
        _confidence = receipt.confidence;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!AiConfig.enabled) {
      return Scaffold(
        appBar: AppBar(title: const Text('Receipt Scanner')),
        body: const Center(child: Text('AI features are disabled.')),
      );
    }

    final padding = Responsive.horizontalPadding(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Receipt Scanner')),
      body: ListView(
        padding: EdgeInsets.all(padding),
        children: [
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: _processing ? null : () => _scan(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt_outlined),
                  label: const Text('Camera'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _processing
                      ? null
                      : () => _scan(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library_outlined),
                  label: const Text('Gallery'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Powered by on-device ML Kit OCR',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).hintColor,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _textController,
            maxLines: 6,
            decoration: const InputDecoration(
              labelText: 'Receipt text (editable)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: _processing ? null : _parseManual,
            child: _processing
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Extract Details'),
          ),
          if (_merchant != null) ...[
            const SizedBox(height: 24),
            if (_confidence != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  'Confidence: ${(_confidence! * 100).toStringAsFixed(0)}%',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            _ResultCard(
              icon: Icons.store_outlined,
              label: 'Merchant',
              value: _merchant!,
            ),
            _ResultCard(
              icon: Icons.payments_outlined,
              label: 'Amount',
              value: '${_amount?.toStringAsFixed(2)} AED',
            ),
            _ResultCard(
              icon: Icons.category_outlined,
              label: 'Category',
              value: _category ?? 'other',
            ),
            _ResultCard(
              icon: Icons.calendar_today_outlined,
              label: 'Date',
              value: _date?.toString().split(' ').first ?? '',
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () => context.pushBudget(),
              icon: const Icon(Icons.savings_outlined),
              label: const Text('Add to Budget Tracking'),
            ),
          ],
        ],
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primaryBlue),
        title: Text(label),
        subtitle: Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
    );
  }
}
