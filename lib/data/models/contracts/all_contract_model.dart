
// models/contracts/all_contract_model.dart

class AllContractModel {
  final String id;
  final String job;
  final String client;
  final String clientProfileImage;
  final String professional;
  final String startDate;
  final String endDate;
  final String terms;
  final PaymentDetails paymentDetails;
  final String signedDate;

  // New fields from jobId
  final String status;
  final String jobType;
  final String jobDuration;
  final String jobCategory;
  final String location;

  AllContractModel({
    required this.id,
    required this.job,
    required this.client,
    this.clientProfileImage = '',
    required this.professional,
    required this.startDate,
    required this.endDate,
    required this.terms,
    required this.paymentDetails,
    required this.signedDate,
    this.status = 'active',
    this.jobType = '',
    this.jobDuration = '',
    this.jobCategory = '',
    this.location = '',
  });

  factory AllContractModel.fromJson(Map<String, dynamic> json) {
    try {
      // Extract client name and profile image from clientId object
      String clientName = '';
      String clientProfileImage = '';
      if (json['clientId'] is Map) {
        clientName = json['clientId']['fullName']?.toString() ?? 'Unknown Client';
        final profile = json['clientId']['profile']?.toString() ?? '';
        clientProfileImage = (profile.isNotEmpty && profile != '' && profile != 'null')
            ? profile
            : '';
      } else {
        clientName = json['clientId']?.toString() ?? 'Unknown Client';
      }

      // Extract professional name from professionalId object
      String professionalName = '';
      if (json['professionalId'] is Map) {
        professionalName = json['professionalId']['fullName']?.toString() ?? 'Unknown Professional';
      } else {
        professionalName = json['professionalId']?.toString() ?? 'Unknown Professional';
      }

      // Extract job details from jobId object
      String jobTitle = '';
      String jobType = '';
      String jobDuration = '';
      String jobCategory = '';
      String location = '';

      if (json['jobId'] is Map) {
        final jobData = json['jobId'] as Map<String, dynamic>;
        jobTitle = jobData['title']?.toString() ?? 'Unknown Job';

        // Extract jobType: "on-site", "remotely", "hybrid"
        jobType = _formatJobType(jobData['jobType']?.toString() ?? '');

        // Extract jobDuration: "3 months", "6 months", "24 months"
        jobDuration = _formatJobDuration(jobData['jobDuration']?.toString() ?? '');

        // Extract jobCategory
        jobCategory = jobData['jobCategory']?.toString() ?? '';

        // Extract location from jobLocation coordinates or use a default
        if (jobData['jobLocation'] is Map) {
          final coords = jobData['jobLocation']['coordinates'] as List?;
          if (coords != null && coords.length >= 2) {
            // You can use a reverse geocoding service here if needed
            // For now, we'll use a placeholder
            location = 'United States'; // Default
          }
        }
      } else {
        jobTitle = json['jobId']?.toString() ?? 'Unknown Job';
      }

      // Get contract status
      String contractStatus = json['status']?.toString() ?? 'active';

      return AllContractModel(
        id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
        job: jobTitle,
        client: clientName,
        clientProfileImage: clientProfileImage,
        professional: professionalName,
        startDate: json['startDate']?.toString() ?? '',
        endDate: json['endDate']?.toString() ?? '',
        terms: json['offerId'] is Map
            ? json['offerId']['description']?.toString() ?? ''
            : json['terms']?.toString() ?? '',
        paymentDetails: json['totalPrice'] != null
            ? PaymentDetails(
          amount: json['totalPrice'] as int? ?? 0,
          currency: 'USD',
        )
            : PaymentDetails(amount: 0, currency: 'USD'),
        signedDate: json['createdAt']?.toString() ?? '',
        status: contractStatus,
        jobType: jobType,
        jobDuration: jobDuration,
        jobCategory: jobCategory,
        location: location.isEmpty ? 'United States' : location,
      );
    } catch (e) {
      print('❌ Error in AllContractModel.fromJson: $e');
      print('📦 Raw JSON: $json');
      rethrow;
    }
  }

  // Helper method to format job type
  static String _formatJobType(String jobType) {
    switch (jobType.toLowerCase()) {
      case 'on-site':
        return 'On-site';
      case 'remotely':
        return 'Remote';
      case 'hybrid':
        return 'Hybrid';
      default:
        return 'Hybrid';
    }
  }

  // Helper method to format job duration
  static String _formatJobDuration(String duration) {
    // Convert "3 months", "6 months", "24 months" to "Part-time" or "Full-time"
    if (duration.isEmpty) return 'Full-time';

    // Extract number from duration
    final numMatch = RegExp(r'\d+').firstMatch(duration);
    if (numMatch != null) {
      final months = int.tryParse(numMatch.group(0) ?? '0') ?? 0;

      // Consider 12+ months as Full-time, less than 12 as Part-time
      if (months >= 12) {
        return 'Full-time';
      } else if (months >= 6) {
        return 'Full-time';
      } else {
        return 'Part-time';
      }
    }

    return 'Full-time';
  }

  @override
  String toString() {
    return 'AllContractModel(id: $id, job: $job, client: $client, '
        'status: $status, jobType: $jobType, duration: $jobDuration, '
        'startDate: $startDate, endDate: $endDate, amount: ${paymentDetails.amount})';
  }
}

class PaymentDetails {
  final int amount;
  final String currency;

  PaymentDetails({
    required this.amount,
    required this.currency,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    try {
      return PaymentDetails(
        amount: json['amount'] as int? ?? 0,
        currency: json['currency']?.toString() ?? 'USD',
      );
    } catch (e) {
      print('❌ Error in PaymentDetails.fromJson: $e');
      return PaymentDetails(amount: 0, currency: 'USD');
    }
  }

  @override
  String toString() => 'PaymentDetails(amount: $amount, currency: $currency)';
}





// class AllContractModel {
//   final String id;
//   final String job;
//   final String client;
//   final String professional;
//   final String startDate;
//   final String endDate;
//   final String terms;
//   final PaymentDetails paymentDetails;
//   final String signedDate;
//
//   AllContractModel({
//     required this.id,
//     required this.job,
//     required this.client,
//     required this.professional,
//     required this.startDate,
//     required this.endDate,
//     required this.terms,
//     required this.paymentDetails,
//     required this.signedDate,
//   });
//
//   factory AllContractModel.fromJson(Map<String, dynamic> json) {
//     return AllContractModel(
//       id: json['_id'],
//       job: json['job'],
//       client: json['client'],
//       professional: json['professional'],
//       startDate: json['startDate'],
//       endDate: json['endDate'],
//       terms: json['terms'],
//       paymentDetails: PaymentDetails.fromJson(json['paymentDetails']),
//       signedDate: json['signedDate'],
//     );
//   }
// }
//
// class PaymentDetails {
//   final int amount;
//   final String currency;
//
//   PaymentDetails({
//     required this.amount,
//     required this.currency,
//   });
//
//   factory PaymentDetails.fromJson(Map<String, dynamic> json) {
//     return PaymentDetails(
//       amount: json['amount'],
//       currency: json['currency'],
//     );
//   }
// }
