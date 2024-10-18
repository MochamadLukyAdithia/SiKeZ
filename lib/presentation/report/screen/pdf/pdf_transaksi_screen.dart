import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:hmj_apps/core/extension/string_extension.dart';
import 'package:hmj_apps/core/helper/format_currency.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_transaction_list_controller.dart';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfTransaksiPreview extends GetView<ReportTransactionListController> {
  const PdfTransaksiPreview({super.key});

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
        title: const Text("PDF Transaksi Preview"),
      ),
      body: PdfPreview(
          actionBarTheme: const PdfActionBarTheme(
              backgroundColor: AppColors.secondaryColor),
          build: (context) => makeTransaksiPdf(controller)),
    );
  }
}

Future<Uint8List> makeTransaksiPdf(
    ReportTransactionListController controller) async {
  final transactionList = controller.getReport();
  final pdf = pw.Document();
  int rowPerPage = 10;
  int totalPage = (transactionList.length / rowPerPage).ceil();
  pw.Widget paddedCell(pw.Widget child) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8.0),
      child: child,
    );
  }

  if (transactionList.isEmpty) {
    pdf.addPage(pw.Page(
      build: (context) {
        return pw.Center(child: pw.Text("Tidak Ada Transaksi"));
      },
    ));
  } else {
    for (var pageIdx = 0; pageIdx < totalPage; pageIdx++) {
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
                            pw.Header(text: "Laporan Jurnal Umum", level: 1),
                            pw.Spacer(),
                            pw.Text("Rentan Waktu",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                          ]),
                      pw.Divider(borderStyle: pw.BorderStyle.dashed),
                      pw.SizedBox(height: 5),
                      pw.Table(border: pw.TableBorder.all(), children: [
                        pw.TableRow(children: [
                          paddedCell(
                            pw.Text("Tanggal",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                          ),
                          paddedCell(
                            pw.Text("Nama Akun",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                          ),
                          paddedCell(pw.Text("Nominal",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold))),
                          // paddedCell(pw.Text("Kredit",
                          //     style:
                          //         pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                        ]),
                        for (var index = pageIdx * rowPerPage;
                            index < (pageIdx + 1) * rowPerPage &&
                                index < transactionList.length;
                            index++) ...[
                          // pw.TableRow(children: [
                          //   paddedCell(pw.Text(
                          //       transactionList[index].transactionName,
                          //       style: pw.TextStyle(
                          //           fontWeight: pw.FontWeight.bold))),
                          // ]),
                          pw.TableRow(children: [
                            paddedCell(pw.Text(DateFormat.yMMMd()
                                .format(transactionList[index].date))),
                            paddedCell(pw.Text(
                                transactionList[index].transactionName,
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold))),
                            pw.SizedBox(),
                            // paddedCell(pw.Text(transactionList[index]
                            //     .nominal
                            //     .toString()
                            //     .currentcy)),
                            // paddedCell(pw.Text("Rp.0"))
                          ]),
                          pw.TableRow(children: [
                            pw.SizedBox(),
                            paddedCell(pw.Text(
                                "${transactionList[index].debitName} -> ${transactionList[index].creditName}")),
                            paddedCell(pw.Text(formatCurrency(
                                transactionList[index].nominal))),
                            // paddedCell(pw.Text(transactionList[index]
                            //     .nominal
                            //     .toString()
                            //     .currentcy))
                          ]),
                        ],
                      ]),
                    ]));
          },
        ),
      );
    }
  }

  return pdf.save();
}
