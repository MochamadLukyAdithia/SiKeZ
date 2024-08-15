import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmj_apps/core/route/routes.dart';
import 'package:hmj_apps/presentation/dasboard/component/dasboard_body.dart';
import 'package:hmj_apps/presentation/dasboard/component/dasboard_header.dart';
import 'package:hmj_apps/presentation/dasboard/component/dashboard_center.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SingleChildScrollView(
        child: Column(
          children: [
            DasboardHeader(),
            DashboardCenter(),
            DashboardBody(),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
                colors: [Color(0xffA1B57D), Color(0xff464F37)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () async {
            // final List<Map<String, dynamic>> transactionTypeList = [
            //   {"id": 1, "name": "Penjualan Tunai"},
            //   {"id": 2, "name": "Pembelian Tunai"},
            //   {"id": 3, "name": "Penjualan Kredit"},
            //   {"id": 4, "name": "Pembelian Kredit"},
            //   {"id": 5, "name": "Pengeluaran Beban-beban"},
            //   {"id": 6, "name": "Penambahan Modal"},
            //   {"id": 7, "name": "Pengambilan Modal"},
            //   {"id": 8, "name": "Pinjaman Bank"},
            // ];

            // final CollectionReference collectionRef =
            //     FirebaseFirestore.instance.collection('transaction_type');

            // for (final transactionType in transactionTypeList) {
            //   await collectionRef.doc(transactionType['id'].toString()).set({
            //     'id': transactionType['id'],
            //     'name': transactionType['name'],
            //   });
            // }
            // AuthController.find.getUser();
            Get.toNamed(AppRoute.addTransaction);

            // final List<Map<String, String>> accountList = [
            //   {"code": "1-1100", "name": "Kas"},
            //   {"code": "1-1200", "name": "Rekening Bank"},
            //   {"code": "1-1300", "name": "Piutang Usaha"},
            //   {"code": "1-1410", "name": "Persediaan Bibit"},
            //   {"code": "1-1420", "name": "Persediaan Pupuk"},
            //   {"code": "1-1500", "name": "Perlengkapan"},
            //   {"code": "1-1600", "name": "Aset Lancar Lainnya"},
            //   {"code": "1-2100", "name": "Aset Tetap Tanah"},
            //   {"code": "1-2200", "name": "Aset Tetap Peralatan dan Mesin"},
            //   {
            //     "code": "1-2210",
            //     "name": "Akumulasi Penyusutan Peralatan dan Mesin"
            //   },
            //   {"code": "1-2300", "name": "Aset Tetap Kendaraan"},
            //   {"code": "1-2310", "name": "Akumulasi Penyusutan Kendaraan"},
            //   {"code": "1-2400", "name": "Aset Tak Berwujud"},
            //   {"code": "2-1100", "name": "Hutang Usaha"},
            //   {"code": "2-1200", "name": "Hutang Lainnya"},
            //   {"code": "2-1300", "name": "Hutang Gaji"},
            //   {"code": "2-2100", "name": "Hutang Bank"},
            //   {"code": "3-1100", "name": "Modal Pemilik"},
            //   {"code": "3-1200", "name": "Prive"},
            //   {"code": "3-1300", "name": "Saldo Laba"},
            //   {"code": "4-1100", "name": "Penjualan"},
            //   {"code": "5-1100", "name": "Biaya Bibit, Pupuk, dan Perawatan"},
            //   {"code": "5-1200", "name": "Biaya Air"},
            //   {"code": "5-1300", "name": "Biaya Listrik"},
            //   {"code": "5-1400", "name": "Biaya Gaji"},
            //   {"code": "5-1500", "name": "Biaya Transportasi"},
            //   {"code": "5-1600", "name": "Beban Penyusutan"},
            //   {"code": "5-1700", "name": "Beban Lain-lain"},
            // ];

            // try {
            //   final CollectionReference collectionRef =
            //       FirebaseFirestore.instance.collection('accounts');

            //   for (final account in accountList) {
            //     print(account);
            //     await collectionRef.doc(account['code']).set({
            //       'code': account['code'],
            //       'name': account['name'],
            //     });
            //   }
            // } on FirebaseException catch (e) {
            //   print(e.message);
            // }
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
