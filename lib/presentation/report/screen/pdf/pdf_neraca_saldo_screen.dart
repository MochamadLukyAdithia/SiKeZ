import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/extension/string_extension.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_neraca_saldo_controller.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfNeracaSaldoPreview extends GetView<ReportNeracaSaldoController> {
  const PdfNeracaSaldoPreview({super.key});

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
        title: const Text("PDF Neraca Saldo Preview"),
      ),
      body: PdfPreview(
        build: (context) => makeNeracaSaldoPdf(controller),
        actionBarTheme:
            const PdfActionBarTheme(backgroundColor: AppColors.secondaryColor),
      ),
    );
  }
}

Future<Uint8List> makeNeracaSaldoPdf(
    ReportNeracaSaldoController controller) async {
  final pdf = pw.Document();
  pw.Widget paddedCell(pw.Widget child) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(5.0),
      child: child,
    );
  }

  final neracaSaldoData = controller.getReport();

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
                        pw.Header(text: "Laporan Neraca Saldo", level: 1),
                        pw.Spacer(),
                        pw.Text("Rentan Waktu",
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ]),
                  pw.Divider(borderStyle: pw.BorderStyle.dashed),
                  pw.SizedBox(height: 5),
                  pw.Table(
                      columnWidths: {
                        0: pw.FixedColumnWidth(
                            250), // Fixed width for the first column
                        1: pw.FlexColumnWidth(
                            2), // Proportional width for the second column
                        2: pw.FlexColumnWidth(
                            2), // Proportional width for the third column
                      },
                      border: pw.TableBorder.all(),
                      children: [
                        pw.TableRow(children: [
                          paddedCell(
                            pw.Text("Nama",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                          ),
                          paddedCell(pw.Text("Debit",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold))),
                          paddedCell(pw.Text("Kredit",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold))),
                        ]),
                        for (var i = 0; i < neracaSaldoData.length; i++) ...[
                          pw.TableRow(children: [
                            paddedCell(pw.Text(neracaSaldoData[i].accountName)),
                            paddedCell(pw.Text(
                                neracaSaldoData[i].debit.toString().currentcy)),
                            paddedCell(pw.Text(
                                neracaSaldoData[i].credit.toString().currentcy))
                          ]),
                        ],

                        // pw.TableRow(children: [
                        //   paddedCell(pw.Text("Pendapatan")),
                        //   paddedCell(pw.Text("Rp. 3000")),
                        //   paddedCell(pw.Text("Rp.2000"))
                        // ]),
                      ]),
                ]));
      },
    ),
  );
  return pdf.save();
}
