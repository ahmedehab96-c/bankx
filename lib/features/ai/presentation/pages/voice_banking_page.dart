import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/usecases/ai_usecases.dart';

/// Voice banking — English and Arabic voice commands.
class VoiceBankingPage extends StatefulWidget {
  const VoiceBankingPage({super.key});

  @override
  State<VoiceBankingPage> createState() => _VoiceBankingPageState();
}

class _VoiceBankingPageState extends State<VoiceBankingPage> {
  final _speech = stt.SpeechToText();
  bool _listening = false;
  String _lastWords = '';
  String _locale = 'en_US';
  String? _result;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    await _speech.initialize();
    setState(() {});
  }

  Future<void> _listen() async {
    if (!_speech.isAvailable) return;

    setState(() {
      _listening = true;
      _lastWords = '';
      _result = null;
    });

    await _speech.listen(
      onResult: (result) {
        setState(() => _lastWords = result.recognizedWords);
        if (result.finalResult) {
          _processCommand(result.recognizedWords);
        }
      },
      listenOptions: stt.SpeechListenOptions(localeId: _locale),
    );
  }

  Future<void> _stop() async {
    await _speech.stop();
    setState(() => _listening = false);
  }

  Future<void> _processCommand(String text) async {
    final locale = _locale.startsWith('ar') ? 'ar' : 'en';
    final useCase = getIt<ParseVoiceCommandUseCase>();
    final result = await useCase(VoiceParams(text: text, locale: locale));

    result.fold((f) => setState(() => _result = f.message), (cmd) {
      setState(() {
        _result = 'Intent: ${cmd.intent}';
        _listening = false;
      });
      if (cmd.route != null && mounted) {
        Future<void>.delayed(const Duration(milliseconds: 800), () {
          if (mounted) context.push(cmd.route!);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Banking'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (v) => setState(() => _locale = v),
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'en_US', child: Text('English')),
              PopupMenuItem(value: 'ar_SA', child: Text('العربية')),
            ],
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _listening ? 'Listening...' : 'Tap to speak',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: _listening ? _stop : _listen,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _listening
                        ? AppColors.error.withValues(alpha: 0.15)
                        : AppColors.primaryBlue.withValues(alpha: 0.15),
                    border: Border.all(
                      color: _listening
                          ? AppColors.error
                          : AppColors.primaryBlue,
                      width: 3,
                    ),
                  ),
                  child: Icon(
                    _listening ? Icons.stop_rounded : Icons.mic_rounded,
                    size: 48,
                    color: _listening ? AppColors.error : AppColors.primaryBlue,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              if (_lastWords.isNotEmpty)
                Text(
                  '"$_lastWords"',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              if (_result != null) ...[
                const SizedBox(height: 16),
                Text(
                  _result!,
                  style: const TextStyle(color: AppColors.success),
                ),
              ],
              const SizedBox(height: 32),
              const Text(
                'Try: "Show my balance", "Transfer money", "Recent transactions"',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
