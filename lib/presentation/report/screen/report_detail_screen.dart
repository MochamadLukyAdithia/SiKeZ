import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/theme/app_colors.dart';
import 'package:hmj_apps/core/theme/app_text_theme.dart';
import 'package:hmj_apps/model/transaction_model.dart';
import 'package:intl/intl.dart';

class ReportDetailScreen extends StatelessWidget {
  const ReportDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TransactionModel transaction = Get.arguments as TransactionModel;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
        title: const Text("Detail Laporan"),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {},
          )
        ],
        
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Transaksi"),
                  Text(
                    "pemasukan",
                    style: AppTextStyle.body2
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Tanggal"),
                  Text(
                    DateFormat.yMMMd().format(transaction.date),
                    style: AppTextStyle.body2
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Nominal"),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Rp.${transaction.nominal.toString()}",
                    style: AppTextStyle.body2
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const Text("Alamat Penerima"),
              const SizedBox(
                height: 10,
              ),
              Table(
                border: TableBorder.all(), // Add borders to cells
                children: [
                  TableRow(
                    children: [
                      TableCell(
                          child: Center(
                              child: Text(
                        'Akun',
                        style: AppTextStyle.body3
                            .copyWith(fontWeight: FontWeight.bold),
                      ))),
                      TableCell(
                          child: Center(
                        child: Text('Debit',
                            style: AppTextStyle.body3
                                .copyWith(fontWeight: FontWeight.bold)),
                      )),
                      TableCell(
                          child: Center(
                              child: Text('Kredit',
                                  style: AppTextStyle.body3
                                      .copyWith(fontWeight: FontWeight.bold)))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                          child: Center(child: Text(transaction.debitName))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  "Rp. ${transaction.nominal.toString()}"))),
                      const TableCell(child: Center(child: Text("Rp. 0"))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                          child: Center(child: Text(transaction.creditName))),
                      const TableCell(child: Center(child: Text('Rp. 0'))),
                      TableCell(
                          child: Center(
                              child: Text(
                                  "Rp. ${transaction.nominal.toString()}"))),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Catatan"),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: Text(
                      transaction.notes,
                      textAlign: TextAlign.end,
                      style: AppTextStyle.body2
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const Text("Lampiran"),
              const SizedBox(
                height: 10,
              ),
              transaction.imageUrl != ""
                  ? AspectRatio(
                      aspectRatio: 16 / 10,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(
                                transaction.imageUrl), // Your background image
                            fit: BoxFit
                                .cover, // Adjust the image to cover the entire container
                          ),
                        ),
                      ))
                  : Center(
                      child: Text(
                      "Belum ada bukti dilampirkan",
                      style: AppTextStyle.body4
                          .copyWith(fontWeight: FontWeight.w300),
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
