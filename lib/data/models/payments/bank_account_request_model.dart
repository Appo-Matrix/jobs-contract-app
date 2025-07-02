class BankAccountRequestModel {
  final String userId;
  final String accountNumber;
  final String country;
  final String bankCode;

  BankAccountRequestModel({
    required this.userId,
    required this.accountNumber,
    required this.country,
    required this.bankCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'accountNumber': accountNumber,
      'country': country,
      'bankCode': bankCode,
    };
  }
}
