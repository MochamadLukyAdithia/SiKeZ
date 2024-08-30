import 'package:get/get.dart';
import 'package:hmj_apps/core/controller/base_controller.dart';
import 'package:hmj_apps/presentation/report/controller/report_neraca_saldo_controller.dart';
import 'package:hmj_apps/presentation/report/model/laba_rugi_model.dart';
import 'package:hmj_apps/presentation/report/model/neraca_saldo_model.dart';

class ReportLabaRugiController extends BaseController {
  RxList<NeracaSaldo> dataTotal =
      Get.find<NeracaSaldoController>().getBukuBesarAllSaldoTotal();

  LabaRugi? dataLabarugi;
  RxList<AkunTotalItem> listTotal = <AkunTotalItem>[].obs;
  RxList<int> listTotalLaba = <int>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    dataLabarugi = clasficationAccount();
    listTotal = totalEveryCategories();
    super.onInit();
  }

  countLaba() {
    int total = 0;
    if (listTotal.isNotEmpty) {
      total = ((listTotal[0].total.abs() - listTotal[1].total.abs()) -
              listTotal[2].total.abs()) -
          listTotal[3].total.abs() -
          listTotal[4].total.abs();
    }
    return total;
  }

  totalEveryCategories() {
    RxList<AkunTotalItem> akunTotalItem = <AkunTotalItem>[].obs;
    if (dataLabarugi != null) {
      var totalPendapatanPenjualan = dataLabarugi?.pendapatanPenjualan
          .fold(0, (sum, data) => sum + data.total);
      var totalHargaPokokPenjualan = dataLabarugi?.hargaPokokPenjualan
          .fold(0, (sum, data) => sum + data.total);
      var totalBebanOperasional = dataLabarugi?.bebanOperasional
          .fold(0, (sum, data) => sum + data.total);
      var totalPendapataanLainnya = dataLabarugi?.pendapatanLainnya
          .fold(0, (sum, data) => sum + data.total);
      var totalBebanLainnya =
          dataLabarugi?.bebanLainnya.fold(0, (sum, data) => sum + data.total);

      akunTotalItem.add(AkunTotalItem(
          nama: "Pendapatan dari Penjualan",
          total: totalPendapatanPenjualan ?? 0));
      akunTotalItem.add(AkunTotalItem(
          nama: "harga pokok penjualan", total: totalHargaPokokPenjualan ?? 0));
      akunTotalItem.add(AkunTotalItem(
          nama: "beban operasional", total: totalBebanOperasional ?? 0));
      akunTotalItem.add(AkunTotalItem(
          nama: "pendapatan lainnya", total: totalPendapataanLainnya ?? 0));
      akunTotalItem.add(
          AkunTotalItem(nama: "beban lainnya", total: totalBebanLainnya ?? 0));
    }

    return akunTotalItem;
  }

  clasficationAccount() {
    RxList<AkunItem> akunItems = <AkunItem>[].obs;

    for (var data in dataTotal) {
      akunItems.add(AkunItem(
          nama: data.nama,
          code: data.kode,
          total: data.debit != 0 ? data.debit : data.kredit));
    }
    LabaRugi labaRugi = LabaRugi.classifyData(akunItems);
    return labaRugi;
  }
}
