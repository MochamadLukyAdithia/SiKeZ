class TransactionType {
  final String? code;
  final String? name;

  TransactionType({required this.code, required this.name});

  factory TransactionType.fromJson(Map<String, dynamic> json) =>
      TransactionType(
        code: json['code'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
      };
}
