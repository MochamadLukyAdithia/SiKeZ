class TransactionType {
  final int? id;
  final String? name;

  TransactionType({required this.id, required this.name});

  factory TransactionType.fromJson(Map<String, dynamic> json) =>
      TransactionType(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
