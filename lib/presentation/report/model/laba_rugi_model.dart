import 'dart:convert';

LabaRugi labaRugiFromJson(String str) => LabaRugi.fromJson(json.decode(str));

String labaRugiToJson(LabaRugi data) => json.encode(data.toJson());

class LabaRugi {
  List<AkunItem> pendapatanPenjualan;
  List<AkunItem> hargaPokokPenjualan;
  List<AkunItem> bebanOperasional;
  List<AkunItem> pendapatanLainnya;
  List<AkunItem> bebanLainnya;

  LabaRugi({
    required this.pendapatanPenjualan,
    required this.hargaPokokPenjualan,
    required this.bebanOperasional,
    required this.pendapatanLainnya,
    required this.bebanLainnya,
  });

  // Factory method untuk mengklasifikasikan data
  factory LabaRugi.classifyData(List<AkunItem> items) {
    List<AkunItem> pendapatanPenjualan = [];
    List<AkunItem> hargaPokokPenjualan = [];
    List<AkunItem> bebanOperasional = [];
    List<AkunItem> pendapatanLainnya = [];
    List<AkunItem> bebanLainnya = [];

    for (var item in items) {
      if (item.nama.contains("Penjualan")) {
        pendapatanPenjualan.add(item);
      } else if (item.nama.contains("Harga Pokok Penjualan")) {
        hargaPokokPenjualan.add(item);
      } else if (item.nama.contains("Beban Operasional")) {
        bebanOperasional.add(item);
      } else if (item.nama.contains("Pendapatan Lainnya")) {
        pendapatanLainnya.add(item);
      } else if (item.nama.contains("Beban Lainnya")) {
        bebanLainnya.add(item);
      }
    }

    return LabaRugi(
      pendapatanPenjualan: pendapatanPenjualan,
      hargaPokokPenjualan: hargaPokokPenjualan,
      bebanOperasional: bebanOperasional,
      pendapatanLainnya: pendapatanLainnya,
      bebanLainnya: bebanLainnya,
    );
  }

  factory LabaRugi.fromJson(Map<String, dynamic> json) => LabaRugi(
        pendapatanPenjualan: List<AkunItem>.from(
            json["pendapatanPenjualan"].map((x) => AkunItem.fromJson(x))),
        hargaPokokPenjualan: List<AkunItem>.from(
            json["hargaPokokPenjualan"].map((x) => AkunItem.fromJson(x))),
        bebanOperasional: List<AkunItem>.from(
            json["bebanOperasional"].map((x) => AkunItem.fromJson(x))),
        pendapatanLainnya: List<AkunItem>.from(
            json["pendapatanLainnya"].map((x) => AkunItem.fromJson(x))),
        bebanLainnya: List<AkunItem>.from(
            json["bebanLainnya"].map((x) => AkunItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pendapatanPenjualan":
            List<dynamic>.from(pendapatanPenjualan.map((x) => x.toJson())),
        "hargaPokokPenjualan":
            List<dynamic>.from(hargaPokokPenjualan.map((x) => x.toJson())),
        "bebanOperasional":
            List<dynamic>.from(bebanOperasional.map((x) => x.toJson())),
        "pendapatanLainnya":
            List<dynamic>.from(pendapatanLainnya.map((x) => x.toJson())),
        "bebanLainnya": List<dynamic>.from(bebanLainnya.map((x) => x.toJson())),
      };
}

class AkunItem {
  String nama;
  String code;
  int total;

  AkunItem({
    required this.nama,
    required this.code,
    required this.total,
  });

  factory AkunItem.fromJson(Map<String, dynamic> json) => AkunItem(
        nama: json["nama"],
        code: json["code"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "code": code,
        "total": total,
      };
}

class AkunTotalItem {
  String nama;

  int total;

  AkunTotalItem({
    required this.nama,
    required this.total,
  });

  factory AkunTotalItem.fromJson(Map<String, dynamic> json) => AkunTotalItem(
        nama: json["nama"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "total": total,
      };
}
