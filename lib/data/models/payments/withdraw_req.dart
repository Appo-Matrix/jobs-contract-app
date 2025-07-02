class WithdrawRequestModel {
  final String userId;
  final int amount;

  WithdrawRequestModel({required this.userId, required this.amount});

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'amount': amount,
  };
}
