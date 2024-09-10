import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:flutter/material.dart';

class PdfPreveiw extends StatelessWidget {
  const PdfPreveiw({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pdf Preview"),
      ),
      body: PdfPreview(
        build: (context) => makePdf(),
      ),
    );
  }
}

Future<Uint8List> makePdf() async {
  final pdf = pw.Document();
  // final ByteData bytes = await rootBundle.load('assets/phone.png');
  // final Uint8List byteList = bytes.buffer.asUint8List();
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
                        pw.Header(text: "Laporan Neraca", level: 1),
                        // pw.Image(pw.MemoryImage(byteList),
                        //     fit: pw.BoxFit.fitHeight, height: 100, width: 100)
                      ]),
                  pw.Divider(borderStyle: pw.BorderStyle.dashed),
                  pw.Text("ASET",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 5),
                  pw.Table(
                      columnWidths: {
                        0: pw.FixedColumnWidth(
                            60), // Fixed width for the first column
                        1: pw.FlexColumnWidth(
                            2), // Proportional width for the second column
                        2: pw.FlexColumnWidth(
                            1), // Proportional width for the third column
                      },
                      border: pw.TableBorder.all(),
                      children: [
                        pw.TableRow(children: [
                          paddedCell(
                            pw.Text("Nomor",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                          ),
                          paddedCell(
                            pw.Text("Nama Akun",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                          ),
                          paddedCell(pw.Text("Nominal",
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)))
                        ]),
                        pw.TableRow(children: [
                          paddedCell(pw.Text("1")),
                          paddedCell(pw.Text("Rp.2000")),
                          paddedCell(pw.Text("Rp.2000"))
                        ]),
                      ]),
                  pw.SizedBox(height: 10),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Text("Total Aset",
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.SizedBox(width: 20),
                        pw.Text("Rp.2000",
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
                      ]),
                  pw.SizedBox(height: 20),
                  pw.Text("HUTANG",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 5),
                  pw.Table(
                      columnWidths: {
                        0: pw.FixedColumnWidth(
                            60), // Fixed width for the first column
                        1: pw.FlexColumnWidth(
                            2), // Proportional width for the second column
                        2: pw.FlexColumnWidth(
                            1), // Proportional width for the third column
                      },
                      border: pw.TableBorder.all(),
                      children: [
                        pw.TableRow(children: [
                          paddedCell(
                            pw.Text("Nomor",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                          ),
                          paddedCell(
                            pw.Text("Nama Akun",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                          ),
                          paddedCell(pw.Text("Nominal",
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)))
                        ]),
                        pw.TableRow(children: [
                          paddedCell(pw.Text("1")),
                          paddedCell(pw.Text("Rp.2000")),
                          paddedCell(pw.Text("Rp.2000"))
                        ]),
                      ]),
                  pw.SizedBox(height: 20),
                  pw.Text("MODAL",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 5),
                  pw.Table(
                      columnWidths: {
                        0: pw.FixedColumnWidth(
                            60), // Fixed width for the first column
                        1: pw.FlexColumnWidth(
                            2), // Proportional width for the second column
                        2: pw.FlexColumnWidth(
                            1), // Proportional width for the third column
                      },
                      border: pw.TableBorder.all(),
                      children: [
                        pw.TableRow(children: [
                          paddedCell(
                            pw.Text("Nomor",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                          ),
                          paddedCell(
                            pw.Text("Nama Akun",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                          ),
                          paddedCell(pw.Text("Nominal",
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)))
                        ]),
                        pw.TableRow(children: [
                          paddedCell(pw.Text("1")),
                          paddedCell(pw.Text("Rp.2000")),
                          paddedCell(pw.Text("Rp.2000"))
                        ]),
                      ]),
                  pw.SizedBox(height: 10),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Text("Total Hutang dan Modal ",
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.SizedBox(width: 20),
                        pw.Text("Rp.2000",
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
                      ]),
                ]));
      },
    ),
  );
  return pdf.save();
}
