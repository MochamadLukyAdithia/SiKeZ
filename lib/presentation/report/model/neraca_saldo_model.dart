import 'dart:convert';

List<NeracaSaldo> neracaSaldoFromJson(String str) => List<NeracaSaldo>.from(json.decode(str).map((x) => NeracaSaldo.fromJson(x)));

String neracaSaldoToJson(List<NeracaSaldo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NeracaSaldo {
    String nama;
    String kode;
    int debit;
    int kredit;

    NeracaSaldo({
        required this.nama,
        required this.kode,
        required this.debit,
        required this.kredit,
    });

    factory NeracaSaldo.fromJson(Map<String, dynamic> json) => NeracaSaldo(
        nama: json["nama"],
        kode: json["kode"],
        debit: json["debit"],
        kredit: json["kredit"],
    );

    Map<String, dynamic> toJson() => {
        "nama": nama,
        "kode": kode,
        "debit": debit,
        "kredit": kredit,
    };
}
