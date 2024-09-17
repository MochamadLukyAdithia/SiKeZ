import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/extension/string_extension.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:flutter/material.dart';

import '../../controller/updated_controller/report_neraca_controller.dart';

class PdfPreveiw extends GetView<ReportNeracaController> {
  const PdfPreveiw({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pdf Neraca Preview"),
      ),
      body: PdfPreview(
        build: (context) => makePdf(controller),
      ),
    );
  }
}

Future<Uint8List> makePdf(ReportNeracaController controller) async {
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
        final data = controller.getReport();
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
                        for (var asetIdx = 0;
                            asetIdx < data.hartaLancarList.length;
                            asetIdx++) ...[
                          pw.TableRow(children: [
                            paddedCell(pw.Text("${asetIdx + 1}")),
                            paddedCell(
                                pw.Text(data.hartaLancarList[asetIdx].name)),
                            paddedCell(pw.Text(
                              data.hartaLancarList[asetIdx].nominal >= 0
                                  ? data.hartaLancarList[asetIdx].nominal
                                      .toString()
                                      .currentcy
                                  : "(${data.hartaLancarList[asetIdx].nominal.abs().toString().currentcy})",
                            ))
                          ]),
                        ]
                      ]),
                  pw.SizedBox(height: 10),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Text("Total Aset",
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.SizedBox(width: 20),
                        pw.Text(
                            data.hartaLancarTotal >= 0
                                ? data.hartaLancarTotal.toString().currentcy
                                : "(${(data.hartaLancarTotal.abs().toString().currentcy)})",
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
                        for (var hutangIdx = 0;
                            hutangIdx < data.hutangList.length;
                            hutangIdx++) ...[
                          pw.TableRow(children: [
                            paddedCell(pw.Text("${hutangIdx + 1}")),
                            paddedCell(
                                pw.Text(data.hutangList[hutangIdx].name)),
                            paddedCell(pw.Text(
                              data.hutangList[hutangIdx].nominal >= 0
                                  ? data.hutangList[hutangIdx].nominal
                                      .toString()
                                      .currentcy
                                  : "(${data.hutangList[hutangIdx].nominal.abs().toString().currentcy})",
                            ))
                          ]),
                        ],
                        pw.TableRow(children: [
                          pw.SizedBox(),
                          paddedCell(pw.Text("Total Hutang",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold))),
                          paddedCell(pw.Text(
                              data.hutangTotal >= 0
                                  ? data.hutangTotal.toString().currentcy
                                  : "(${data.hutangTotal.abs().toString().currentcy})",
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)))
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
                          paddedCell(pw.Text("${1}")),
                          paddedCell(pw.Text("Laba Rugi")),
                          paddedCell(pw.Text(
                            data.labaRugi >= 0
                                ? data.labaRugi.toString().currentcy
                                : "(${data.labaRugi.abs().toString().currentcy})",
                          ))
                        ]),
                        for (var i = 0; i < data.modalList.length; i++) ...[
                          pw.TableRow(children: [
                            paddedCell(pw.Text("${i + 2}")),
                            paddedCell(pw.Text(data.modalList[i].name)),
                            paddedCell(pw.Text(
                              data.modalList[i].nominal >= 0
                                  ? data.modalList[i].nominal
                                      .toString()
                                      .currentcy
                                  : "(${data.modalList[i].nominal.abs().toString().currentcy})",
                            ))
                          ]),
                        ],
                        pw.TableRow(children: [
                          pw.SizedBox(),
                          paddedCell(pw.Text("Total Modal",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold))),
                          paddedCell(pw.Text(
                              data.hutangTotal >= 0
                                  ? data.hutangTotal.toString().currentcy
                                  : "(${data.hutangTotal.abs().toString().currentcy})",
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)))
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
                        pw.Text(
                            (data.modalTotal + data.hutangTotal) >= 0
                                ? (data.modalTotal + data.hutangTotal)
                                    .toString()
                                    .currentcy
                                : "(${(data.modalTotal + data.hutangTotal).abs().toString().currentcy})",
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
                      ]),
                ]));
      },
    ),
  );
  return pdf.save();
}
