import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

/// Extracts raw text from receipt images using on-device ML Kit OCR.
class ReceiptOcrService {
  ReceiptOcrService({TextRecognizer? recognizer})
    : _recognizer =
          recognizer ?? TextRecognizer(script: TextRecognitionScript.latin);

  final TextRecognizer _recognizer;

  Future<String> extractTextFromImage(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final recognizedText = await _recognizer.processImage(inputImage);
    return recognizedText.text.trim();
  }

  void dispose() => _recognizer.close();
}
