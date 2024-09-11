import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfLabaPreviewname extends StatelessWidget {
  const PdfLabaPreviewname({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Laba Rugi Preview"),
      ),
      body: PdfPreview(build: (context) => makeLabaPdf()),
    );
  }
}

Future<Uint8List> makeLabaPdf() async {
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
                        pw.Header(text: "Laporan Laba Rugi", level: 1),
                        // pw.Image(pw.MemoryImage(byteList),
                        //     fit: pw.BoxFit.fitHeight, height: 100, width: 100)
                      ]),
                  pw.Divider(borderStyle: pw.BorderStyle.dashed),
                  // pw.Text("ASET",
                  //     style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
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
                          paddedCell(pw.Text("")),
                          paddedCell(pw.Text("Pendapatan dari penjualan",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold))),
                          paddedCell(pw.Text(""))
                        ]),
                        pw.TableRow(children: [
                          paddedCell(pw.Text("1")),
                          paddedCell(pw.Text("Penambahan Modal")),
                          paddedCell(pw.Text("Rp.2000"))
                        ]),
                        pw.TableRow(children: [
                          paddedCell(pw.Text("")),
                          paddedCell(pw.Text("Harga Pokok Penjualan",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold))),
                          paddedCell(pw.Text(""))
                        ]),
                        pw.TableRow(children: [
                          paddedCell(pw.Text("2")),
                          paddedCell(pw.Text("Laba Bersih")),
                          paddedCell(pw.Text("Rp.2000"))
                        ]),
                        pw.TableRow(children: [
                          pw.SizedBox(),
                          paddedCell(pw.Text("Laba Kotor",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold))),
                          paddedCell(pw.Text("Rp.2000",
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)))
                        ]),
                        pw.TableRow(children: [
                          paddedCell(pw.Text("")),
                          paddedCell(pw.Text("Beban Operasional",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold))),
                          paddedCell(pw.Text(""))
                        ]),
                        pw.TableRow(children: [
                          paddedCell(pw.Text("3")),
                          paddedCell(pw.Text("Prive")),
                          paddedCell(pw.Text("Rp.2000"))
                        ]),
                        pw.TableRow(children: [
                          pw.SizedBox(),
                          paddedCell(pw.Text("Laba beban Operasional",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold))),
                          paddedCell(pw.Text("Rp.2000",
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)))
                        ]),
                        pw.TableRow(children: [
                          paddedCell(pw.Text("")),
                          paddedCell(pw.Text("Pendapatan Lainnya",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold))),
                          paddedCell(pw.Text(""))
                        ]),
                        pw.TableRow(children: [
                          paddedCell(pw.Text("4")),
                          paddedCell(pw.Text("Pendapatan Lainnya")),
                          paddedCell(pw.Text("Rp.2000"))
                        ]),
                        pw.TableRow(children: [
                          paddedCell(pw.Text("")),
                          paddedCell(pw.Text("Beban Lainnya",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold))),
                          paddedCell(pw.Text(""))
                        ]),
                        pw.TableRow(children: [
                          paddedCell(pw.Text("5")),
                          paddedCell(pw.Text("Beban Lainnya")),
                          paddedCell(pw.Text("Rp.2000"))
                        ]),
                        pw.TableRow(children: [
                          pw.SizedBox(),
                          paddedCell(pw.Text("Laba Bersih",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold))),
                          paddedCell(pw.Text("Rp.2000",
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)))
                        ]),
                      ]),
                  pw.SizedBox(height: 10),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Text("Saldo Akhir",
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
