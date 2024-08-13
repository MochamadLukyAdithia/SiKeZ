import 'package:get/get.dart';
import 'package:hmj_apps/core/controller/base_controller.dart';
import 'package:intl/intl.dart';

class ReportController extends BaseController {
  
  final filterDateFull = [
    "Kemarin",
    "7 Hari Terakhir",
    "30 Hari Terakhir",
    "Bulan ini",
    "Bulan lalu",
    "Pilih range hari",
    "Pilih range bulan"
  ];
  final filterDateMonth = ["Bulan ini", "Bulan lalu", "Pilih bulan"];
  final filterDateonly = ["Pilih Tanggal"];

  RxString choosedFilter = "01".obs;

  changeDate(String filterText) {
    choosedFilter.value = filterText;
  }

  String displayChoosedDate(int numberOfDay){
    return DateFormat.yMd().format(DateTime.now().subtract(Duration(days:numberOfDay)));
  }

  List chosedFilterListForPage(String pageName) {
    if (pageName == "jurnal" || pageName == "labaRugi") {
      return filterDateFull;
    } else if (pageName == "neracaSaldo" || pageName == "bukuBesar") {
      return filterDateMonth;
    } else {
      return filterDateonly;
    }
  }
}
