import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/extension/string_extension.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../controller/updated_controller/report_modal_controller.dart';

class PdfModalPreviewname extends GetView<ReportModalController> {
  const PdfModalPreviewname({super.key});

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
        title: const Text("PDF Modal Preview"),
      ),
      body: PdfPreview(
        build: (context) => makeModalPdf(controller),
        actionBarTheme:
            const PdfActionBarTheme(backgroundColor: AppColors.secondaryColor),
      ),
    );
  }
}

Future<Uint8List> makeModalPdf(ReportModalController controller) async {
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
        final modalData = controller.getReport();
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
                          pw.SizedBox(),
                          paddedCell(pw.Text("Modal Awal",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold))),
                          paddedCell(pw.Text(
                              modalData.modalAwal.toString().currentcy,
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)))
                        ]),
                        pw.TableRow(children: [
                          paddedCell(pw.Text("1")),
                          paddedCell(pw.Text("Penambahan Modal")),
                          paddedCell(pw.Text(
                            modalData.addedModalAmount.toString().currentcy,
                          ))
                        ]),
                        pw.TableRow(children: [
                          paddedCell(pw.Text("2")),
                          paddedCell(pw.Text("Laba Bersih")),
                          paddedCell(pw.Text(
                            (modalData.cleanLaba > 0 ? modalData.cleanLaba : 0)
                                .toString()
                                .currentcy,
                          ))
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
                        pw.TableRow(children: [
                          paddedCell(pw.Text("1")),
                          paddedCell(pw.Text("Pengambilan Modal")),
                          paddedCell(pw.Text(
                            modalData.takedModalAmount.toString().currentcy,
                          ))
                        ]),
                        pw.TableRow(children: [
                          paddedCell(pw.Text("2")),
                          paddedCell(pw.Text("Rugi Bersih")),
                          paddedCell(pw.Text(
                            min(modalData.cleanLaba, 0).toString().currentcy,
                          ))
                        ]),
                        pw.TableRow(children: [
                          pw.SizedBox(),
                          paddedCell(pw.Text("Total Pengurang",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold))),
                          paddedCell(pw.Text(
                              ((modalData.cleanLaba < 0
                                          ? modalData.cleanLaba
                                          : 0) +
                                      modalData.takedModalAmount)
                                  .toString()
                                  .currentcy,
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)))
                        ]),
                        pw.TableRow(children: [
                          pw.SizedBox(),
                          paddedCell(pw.Text("Perubahan Modal",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold))),
                          paddedCell(pw.Text(
                              (modalData.getModalAkhir - modalData.modalAwal)
                                  .toString()
                                  .currentcy,
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
                        pw.Text(modalData.getModalAkhir.toString().currentcy,
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
                      ]),
                ]));
      },
    ),
  );
  return pdf.save();
}
