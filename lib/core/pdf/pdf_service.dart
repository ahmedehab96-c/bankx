import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

import '../../shared/domain/entities/transaction.dart';

/// Generates a professional bank statement PDF from transactions.
class BankStatementPdfGenerator {
  Future<Uint8List> generate({
    required String accountName,
    required String accountNumber,
    required List<Transaction> transactions,
    required DateTime from,
    required DateTime to,
  }) async {
    final doc = pw.Document();
    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Text(
              'BankX — Account Statement',
              style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.SizedBox(height: 12),
          pw.Text('Account: $accountName'),
          pw.Text('Number: $accountNumber'),
          pw.Text(
            'Period: ${from.toIso8601String().split('T').first} — ${to.toIso8601String().split('T').first}',
          ),
          pw.SizedBox(height: 20),
          pw.TableHelper.fromTextArray(
            headers: const ['Date', 'Description', 'Amount', 'Status'],
            data: transactions
                .map(
                  (t) => [
                    t.date.toIso8601String().split('T').first,
                    t.title,
                    '${t.type.name == 'income' ? '+' : '-'}${t.amount.toStringAsFixed(2)} ${t.currency}',
                    t.status.name,
                  ],
                )
                .toList(),
          ),
        ],
      ),
    );
    return doc.save();
  }
}

/// Generates a transfer receipt PDF.
class TransferReceiptPdfGenerator {
  Future<Uint8List> generate({
    required String reference,
    required String fromAccount,
    required String beneficiary,
    required double amount,
    required String currency,
    required DateTime date,
  }) async {
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'BankX — Transfer Receipt',
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 24),
            pw.Text('Reference: $reference'),
            pw.Text('Date: ${date.toIso8601String()}'),
            pw.Text('From: $fromAccount'),
            pw.Text('To: $beneficiary'),
            pw.SizedBox(height: 12),
            pw.Text(
              'Amount: ${amount.toStringAsFixed(2)} $currency',
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
            pw.Spacer(),
            pw.Text('Thank you for banking with BankX.'),
          ],
        ),
      ),
    );
    return doc.save();
  }
}

/// Shares or prints generated PDF documents.
class PdfShareService {
  Future<void> share(Uint8List bytes, String fileName) async {
    final file = XFile.fromData(
      bytes,
      name: fileName,
      mimeType: 'application/pdf',
    );
    await Share.shareXFiles([file], text: 'BankX document');
  }

  Future<void> print(Uint8List bytes, {String name = 'BankX Document'}) async {
    await Printing.layoutPdf(onLayout: (_) async => bytes, name: name);
  }
}
