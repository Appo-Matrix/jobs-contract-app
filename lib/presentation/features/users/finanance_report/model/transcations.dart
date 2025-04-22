class Transaction {
  final String method;
  final String date;
  final String amount;

  Transaction({
    required this.method,
    required this.date,
    required this.amount,
  });

  bool get isPositive => amount.startsWith('+');

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      method: map['method'],
      date: map['date'],
      amount: map['amount'],
    );
  }
}
