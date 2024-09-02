import 'dart:convert';

List<Neraca> neracaFromJson(String str) =>
    List<Neraca>.from(json.decode(str).map((x) => Neraca.fromJson(x)));

String neracaToJson(List<Neraca> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Neraca {
  String nama;
  String kode;
  int nominal;

  Neraca({required this.nama, required this.kode, required this.nominal});

  factory Neraca.fromJson(Map<String, dynamic> json) => Neraca(
        nama: json["nama"],
        kode: json["kode"],
        nominal: json["nominal"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "kode": kode,
        "nominal": nominal,
      };
}
