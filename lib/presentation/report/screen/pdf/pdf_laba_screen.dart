import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/extension/string_extension.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_laba_controller.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfLabaPreviewname extends GetView<ReportLabaController> {
  const PdfLabaPreviewname({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
        foregroundColor: Colors.white,
        title: const Text("PDF Laba Rugi Preview"),
      ),
      body: PdfPreview(
        build: (context) => makeLabaPdf(controller),
        actionBarTheme:
            const PdfActionBarTheme(backgroundColor: AppColors.secondaryColor),
      ),
    );
  }
}

Future<Uint8List> makeLabaPdf(ReportLabaController controller) async {
  final pdf = pw.Document();
  // final ByteData bytes = await rootBundle.load('assets/phone.png');
  // final Uint8List byteList = bytes.buffer.asUint8List();
  final data = controller.getReport();
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
                        for (var bebanIdx = 0;
                            bebanIdx <
                                data.pendapatanDariPenjualan.items.length;
                            bebanIdx++) ...[
                          pw.TableRow(children: [
                            paddedCell(pw.Text("${bebanIdx + 1}")),
                            paddedCell(pw.Text(data
                                .pendapatanDariPenjualan.items[bebanIdx].name)),
                            paddedCell(pw.Text(
                                "${data.pendapatanDariPenjualan.items[bebanIdx].amount}"
                                    .currentcy))
                          ]),
                        ],
                        pw.TableRow(children: [
                          paddedCell(pw.Text("")),
                          paddedCell(pw.Text("Harga Pokok Penjualan",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold))),
                          paddedCell(pw.Text(""))
                        ]),
                        for (var bebanIdx = 0;
                            bebanIdx < data.bebanOperasional.items.length;
                            bebanIdx++) ...[
                          pw.TableRow(children: [
                            paddedCell(pw.Text("${bebanIdx + 1}")),
                            paddedCell(pw.Text(
                                data.bebanOperasional.items[bebanIdx].name)),
                            paddedCell(pw.Text(
                                "${data.bebanOperasional.items[bebanIdx].amount}"
                                    .currentcy))
                          ]),
                        ],
                        pw.TableRow(children: [
                          pw.SizedBox(),
                          paddedCell(pw.Text("Laba Kotor",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold))),
                          paddedCell(pw.Text(
                              data.pendapatanDariPenjualan.totalAmount
                                  .toString()
                                  .currentcy,
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
                        for (var bebanIdx = 0;
                            bebanIdx < data.bebanLainya.items.length;
                            bebanIdx++) ...[
                          pw.TableRow(children: [
                            paddedCell(pw.Text("${bebanIdx + 1}")),
                            paddedCell(
                                pw.Text(data.bebanLainya.items[bebanIdx].name)),
                            paddedCell(pw.Text(
                                "${data.bebanLainya.items[bebanIdx].amount}"
                                    .currentcy))
                          ]),
                        ],
                        pw.TableRow(children: [
                          pw.SizedBox(),
                          paddedCell(pw.Text("Laba beban Operasional",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold))),
                          paddedCell(pw.Text(
                              (data.pendapatanDariPenjualan.totalAmount -
                                      data.bebanOperasional.totalAmount)
                                  .toString()
                                  .currentcy,
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)))
                        ]),
                        // pw.TableRow(children: [
                        //   paddedCell(pw.Text("")),
                        //   paddedCell(pw.Text("Pendapatan Lainnya",
                        //       style: pw.TextStyle(
                        //           fontWeight: pw.FontWeight.bold))),
                        //   paddedCell(pw.Text(""))
                        // ]),
                        // pw.TableRow(children: [
                        //   paddedCell(pw.Text("4")),
                        //   paddedCell(pw.Text("Pendapatan Lainnya")),
                        //   paddedCell(pw.Text("Rp.2000"))
                        // ]),
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
                          paddedCell(pw.Text(data.bebanLainya.totalAmount
                              .toString()
                              .currentcy))
                        ]),
                        // pw.TableRow(children: [
                        //   pw.SizedBox(),
                        //   paddedCell(pw.Text("Laba Bersih",
                        //       style: pw.TextStyle(
                        //           fontWeight: pw.FontWeight.bold))),
                        //   paddedCell(pw.Text("Rp.2000",
                        //       style:
                        //           pw.TextStyle(fontWeight: pw.FontWeight.bold)))
                        // ]),
                      ]),
                  pw.SizedBox(height: 10),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Text("Laba Bersih",
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.SizedBox(width: 20),
                        pw.Text(data.cleanResult.toString().currentcy,
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
                      ]),
                ]));
      },
    ),
  );
  return pdf.save();
}
