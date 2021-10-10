enum TransactionType { lend, pay }

class TransactionItemModel {
  TransactionItemModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.photoUrl,
    required this.type,
  });

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String photoUrl;
  final TransactionType type;

  factory TransactionItemModel.fromJson(Map<String, dynamic> json) {
    return TransactionItemModel(
      id: json['id'],
      title: json['title'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      photoUrl: json['photoUrl'],
      type: json['type'] == 'lend' ? TransactionType.lend : TransactionType.pay,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'photoUrl': photoUrl,
      'type': type == TransactionType.lend ? 'lend' : 'pay',
    };
  }

  TransactionItemModel copyWith({
    String? id,
    String? title,
    double? amount,
    DateTime? date,
    String? photoUrl,
    TransactionType? type,
  }) {
    return TransactionItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      photoUrl: photoUrl ?? this.photoUrl,
      type: type ?? this.type,
    );
  }

  @override
  String toString() {
    return 'TransactionItemModel{id: $id, title: $title, amount: $amount, date: $date, photoUrl: $photoUrl, type: $type}';
  }
}
