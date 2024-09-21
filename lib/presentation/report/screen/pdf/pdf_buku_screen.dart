import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/extension/string_extension.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/presentation/report/controller/updated_controller/report_book_controller.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfBukuBesarPreview extends GetView<ReportBookController> {
  const PdfBukuBesarPreview({super.key});

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
        title: const Text("PDF Buku Besar Preview"),
      ),
      body: PdfPreview(
          actionBarTheme: const PdfActionBarTheme(
              backgroundColor: AppColors.secondaryColor),
          build: (context) => generatePdf(controller)),
    );
  }
}

Future<Uint8List> makeBukuBesarPdf(ReportBookController controller) async {
  final data = controller.getReport();
  final pdf = pw.Document();
  int rowPerPage = 1;
  int totalPage = (data.length / rowPerPage).ceil();
  pw.Widget paddedCell(pw.Widget child) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8.0),
      child: child,
    );
  }

  if (data.isEmpty) {
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
                            pw.Header(text: "Laporan Buku Besar", level: 1),
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
                            pw.Text("Catatan",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                          ),
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
                        for (var historyIdx = 0;
                            historyIdx < data[pageIdx].history.length;
                            historyIdx++) ...[
                          pw.TableRow(children: [
                            paddedCell(pw.Text("21 agustus 2024")),
                            paddedCell(pw.Text("Penambahan Modal")),
                            paddedCell(pw.Text("Rp.2000"))
                          ]),
                          // pw.TableRow(children: [
                          //   paddedCell(pw.Text("22 agustus 2024")),
                          //   paddedCell(pw.Text("Laba Bersih")),
                          //   paddedCell(pw.Text("Rp.2000"))
                          // ]),
                        ],
                        pw.TableRow(children: [
                          pw.SizedBox(),
                          paddedCell(pw.Text("Saldo Total",
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
    }
  }
  return pdf.save();
}

Future<Uint8List> generatePdf(ReportBookController controller) async {
  final pdf = pw.Document();
  final dataBuku = controller.getReport();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return dataBuku.map((data) {
          int finalAmount = 0;
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(data.account,
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("Tanggal",
                        style: pw.TextStyle(
                            fontSize: 15, fontWeight: pw.FontWeight.bold)),
                    pw.Text("Debit",
                        style: pw.TextStyle(
                            fontSize: 15, fontWeight: pw.FontWeight.bold),
                        textAlign: pw.TextAlign.start),
                    pw.Text("Kredit",
                        style: pw.TextStyle(
                            fontSize: 15, fontWeight: pw.FontWeight.bold)),
                  ]),
              pw.SizedBox(height: 5),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children:
                    (data.history as List<BookHistoryModel>).map((historyItem) {
                  finalAmount += historyItem.debit;
                  finalAmount -= historyItem.kredit;

                  return pw.Container(
                      margin: pw.EdgeInsets.only(top: 5, bottom: 5),
                      child: pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(DateFormat.yMMMd()
                                .format(historyItem.dateTime)),
                            pw.SizedBox(width: 10),
                            pw.Text("${historyItem.debit.abs()}".currentcy,
                                textAlign: pw.TextAlign.start),
                            pw.SizedBox(width: 10),
                            pw.Text("${historyItem.kredit.abs()}".currentcy),
                          ]));
                }).toList(),
              ),
              pw.SizedBox(height: 10),
              pw.SizedBox(height: 10),
              pw.Row(children: [
                pw.Spacer(),
                pw.Text("Saldo Akhir : ",
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold),
                    textAlign: pw.TextAlign.start),
                pw.Text(
                    finalAmount < 0
                        ? "(${finalAmount.abs().toString().currentcy})"
                        : finalAmount.toString().currentcy,
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold),
                    textAlign: pw.TextAlign.start),
              ]),
              pw.Divider(),
            ],
          );
        }).toList();
      },
    ),
  );

  // Simpan PDF ke file
  return pdf.save();
}
