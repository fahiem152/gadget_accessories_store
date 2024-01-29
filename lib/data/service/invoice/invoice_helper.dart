import 'dart:io';

import 'package:flutter/services.dart';

import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:projecttas_223200007/data/models/transaction_model.dart';
import 'package:projecttas_223200007/data/service/invoice/invoice_pdf_service.dart';
import 'package:projecttas_223200007/shared/formatter/formatter.dart';

class HelperInvoice {
  static late Font ttf;
  static Future<File> generate(TransactionModel invoiceTransaction) async {
    final pdf = Document();
    var data = await rootBundle.load("assets/fonts/noto-sans.ttf");
    ttf = Font.ttf(data);
    final ByteData dataImage =
        await rootBundle.load('assets/images/logo-text.png');
    final Uint8List bytes = dataImage.buffer.asUint8List();

    // Membuat objek Image dari gambar
    final image = pw.MemoryImage(bytes);

    pdf.addPage(
      MultiPage(
        build: (context) => [
          buildHeader(invoiceTransaction, image),
          SizedBox(height: 1 * PdfPageFormat.cm),
          buildInvoice(invoiceTransaction),
          Divider(),
          SizedBox(height: 0.25 * PdfPageFormat.cm),
          buildTotal(invoiceTransaction),
        ],
        footer: (context) => buildFooter(invoiceTransaction),
      ),
    );

    return HelperPdfService.saveDocument(
        name: '${invoiceTransaction.id}.pdf', pdf: pdf);
  }

  static Widget buildHeader(
    TransactionModel invoice,
    MemoryImage image,
  ) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Text('Gadget Accessories Store',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 0.2 * PdfPageFormat.cm),
          Text(
            invoice.id,
            maxLines: 2,
          ),
          SizedBox(height: 0.2 * PdfPageFormat.cm),
          Text(
            Formatter.formatWaktuAndClock(DateTime.fromMillisecondsSinceEpoch(
              invoice.transactionTime,
            )),
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                image,
                width: 150.0,
                height: 150.0,
                fit: BoxFit.fill,
              ),
              buildPaymentInfo(invoice),
            ],
          ),
          SizedBox(height: 0.2 * PdfPageFormat.cm),
          Text(
            'INVOICE',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      );

  static Widget buildPaymentInfo(TransactionModel info) {
    final titles = <String>['Card Number:', 'Cvv:', 'Expired Date:', 'Type:'];
    final data = <String>[
      info.paymentMethod['cardNumber'],
      info.paymentMethod['cvv'],
      info.paymentMethod['expiryDate'],
      info.paymentMethod['type'],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget buildInvoice(TransactionModel invoice) {
    final headers = [
      'Id',
      'Name',
      'Quantity',
      'Unit Price',
      // 'Date',
      'Total'
    ];
    final data = invoice.items.map((item) {
      return [
        item['id'],
        item['name'],
        item['quantity'],
        Formatter.formatRupiah(int.parse(item['price'])),
        Formatter.formatRupiah(int.parse(item['subtotal'])),
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(
          fontWeight: FontWeight.bold, color: PdfColor.fromHex('FFFFFF')),
      headerDecoration: BoxDecoration(color: PdfColors.blue),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.center,
        2: Alignment.center,
        3: Alignment.centerLeft,
        4: Alignment.centerLeft,
      },
    );
  }

  static Widget buildTotal(TransactionModel invoice) {
    final subTotal = invoice.subtotal;
    final adminFee = invoice.adminFee;
    final total = invoice.total;

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Sub Total',
                  value: Formatter.formatRupiah(int.parse(subTotal)),
                  unite: true,
                ),
                buildText(
                  title: 'Admin Fee',
                  value: Formatter.formatRupiah(int.parse(adminFee)),
                  unite: true,
                ),
                Divider(),
                buildText(
                  title: 'Total ',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: Formatter.formatRupiah(int.parse(total)),
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(TransactionModel invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(
              title: 'Address',
              value: 'Street Dawung, Mranggen, Demak, Central Java, 89568'),
          SizedBox(height: 1 * PdfPageFormat.mm),
          buildSimpleText(
              title: 'Paypal',
              value:
                  'https://paypal.me/${invoice.paymentMethod['cardNumber']}'),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
