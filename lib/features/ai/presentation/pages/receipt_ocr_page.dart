import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../domain/usecases/ai_usecases.dart';

/// Receipt OCR — scan and extract merchant, amount, date, category.
class ReceiptOcrPage extends StatefulWidget {
  const ReceiptOcrPage({super.key});

  @override
  State<ReceiptOcrPage> createState() => _ReceiptOcrPageState();
}

class _ReceiptOcrPageState extends State<ReceiptOcrPage> {
  final _textController = TextEditingController();
  bool _processing = false;
  String? _merchant;
  double? _amount;
  String? _category;
  DateTime? _date;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return;

    // Demo: simulate OCR text extraction — replace with ML Kit in production
    _textController.text =
        '''
STARBUCKS COFFEE
Dubai Mall Branch
Date: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}
Total: 45.50 AED
Thank you!
''';
    await _parse();
  }

  Future<void> _parse() async {
    setState(() => _processing = true);
    final useCase = getIt<ParseReceiptUseCase>();
    final result = await useCase(_textController.text);
    result.fold(
      (f) => setState(() => _processing = false),
      (receipt) => setState(() {
        _processing = false;
        _merchant = receipt.merchantName;
        _amount = receipt.amount;
        _category = receipt.category;
        _date = receipt.date;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.horizontalPadding(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Receipt Scanner')),
      body: ListView(
        padding: EdgeInsets.all(padding),
        children: [
          FilledButton.icon(
            onPressed: _pickImage,
            icon: const Icon(Icons.camera_alt_outlined),
            label: const Text('Scan Receipt'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _textController,
            maxLines: 6,
            decoration: const InputDecoration(
              labelText: 'Receipt text (OCR output)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: _processing ? null : _parse,
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
