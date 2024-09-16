import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfBukuBesarPreview extends StatelessWidget {
  const PdfBukuBesarPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Modal Preview"),
      ),
      body: PdfPreview(build: (context) => makeBukuBesarPdf()),
    );
  }
}

Future<Uint8List> makeBukuBesarPdf() async {
  final pdf = pw.Document();
  pw.Widget paddedCell(pw.Widget child) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8.0),
      child: child,
    );
  }

  pdf.addPage(
    pw.Page(
      margin: const pw.EdgeInsets.all(10),
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Padding(
            padding: const pw.EdgeInsets.only(
                top: 40, left: 40, right: 30, bottom: 30),
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Header(text: "Laporan Buku Besar", level: 1),
                        pw.Spacer(),
                        pw.Text("Rentan Waktu",
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ]),
                  pw.Divider(borderStyle: pw.BorderStyle.dashed),
                  pw.SizedBox(height: 5),
                  pw.Table(
                      // columnWidths: {
                      //   0: pw.FixedColumnWidth(
                      //       60), // Fixed width for the first column
                      //   1: pw.FlexColumnWidth(
                      //       2), // Proportional width for the second column
                      //   2: pw.FlexColumnWidth(
                      //       1), // Proportional width for the third column
                      // },
                      border: pw.TableBorder.all(),
                      children: [
                        pw.TableRow(children: [
                          paddedCell(
                            pw.Text("Tanggal",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                          ),
                          paddedCell(
                            pw.Text("Catatan",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                          ),
                          paddedCell(pw.Text("Nominal",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold))),
                          paddedCell(pw.Text("Debit",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold))),
                          paddedCell(pw.Text("Kredit",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold))),
                          paddedCell(pw.Text("Saldo",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold))),
                        ]),
                        pw.TableRow(children: [
                          paddedCell(pw.Text("Kas (1-10001)",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold))),
                        ]),
                        pw.TableRow(children: [
                          paddedCell(pw.Text("21 agustus 2024")),
                          paddedCell(pw.Text("Penambahan Modal")),
                          paddedCell(pw.Text("Rp.2000"))
                        ]),
                        pw.TableRow(children: [
                          paddedCell(pw.Text("22 agustus 2024")),
                          paddedCell(pw.Text("Laba Bersih")),
                          paddedCell(pw.Text("Rp.2000"))
                        ]),
                        pw.TableRow(children: [
                          pw.SizedBox(),
                          paddedCell(pw.Text("Total Tambahan",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold))),
                          paddedCell(pw.Text("Rp.2000",
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)))
                        ]),
                      ]),
                ]));
      },
    ),
  );
  return pdf.save();
}
