class TransactionModel {
  final String id;
  final String creditCode;
  final String creditName;
  final DateTime date;
  final String debitCode;
  final String debitName;
  final String imageUrl;
  final int nominal;
  final String notes;
  final int transactionId;
  final String transactionName;
  int index;

  TransactionModel({
    required this.id,
    required this.creditCode,
    required this.creditName,
    required this.date,
    required this.debitCode,
    required this.debitName,
    required this.imageUrl,
    required this.nominal,
    required this.notes,
    required this.transactionId,
    required this.transactionName,
    this.index = -1,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      creditCode: json['credit_code'],
      creditName: json['credit_name'],
      date: DateTime.fromMillisecondsSinceEpoch(json['date']),
      debitCode: json['debit_code'],
      debitName: json['debit_name'],
      imageUrl: json['imageUrl'],
      nominal: json['nominal'],
      notes: json['notes'],
      transactionId: json['transaction_id'],
      transactionName: json['transaction_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'credit_code': creditCode,
      'credit_name': creditName,
      'date': date.millisecondsSinceEpoch,
      'debit_code': debitCode,
      'debit_name': debitName,
      'imageUrl': imageUrl,
      'nominal': nominal,
      'notes': notes,
      'transaction_id': transactionId,
      'transaction_name': transactionName,
    };
  }

  TransactionModel newWithIndex(int index) {
    return TransactionModel(
      id: id,
      creditCode: creditCode,
      creditName: creditName,
      date: date,
      debitCode: debitCode,
      debitName: debitName,
      imageUrl: imageUrl,
      nominal: nominal,
      notes: notes,
      transactionId: transactionId,
      transactionName: transactionName,
      index: index,
    );
  }
}
