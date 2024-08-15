class Accounts {
  final String? code;
  final String? name;

  Accounts({required this.code, required this.name});

  factory Accounts.fromJson(Map<String, dynamic> json) => Accounts(
        code: json['code'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
      };
}
