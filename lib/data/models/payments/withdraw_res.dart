class WithdrawResponseModel {
  final String message;
  final Transfer transfer;

  WithdrawResponseModel({required this.message, required this.transfer});

  factory WithdrawResponseModel.fromJson(Map<String, dynamic> json) {
    return WithdrawResponseModel(
      message: json['message'],
      transfer: Transfer.fromJson(json['transfer']),
    );
  }
}

class Transfer {
  final String id;
  final int amount;
  final String currency;

  Transfer({required this.id, required this.amount, required this.currency});

  factory Transfer.fromJson(Map<String, dynamic> json) {
    return Transfer(
      id: json['id'],
      amount: json['amount'],
      currency: json['currency'],
    );
  }
}
