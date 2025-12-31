// data/data_source/remote/contract_remote_data_source.dart

import 'package:dio/dio.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../models/contracts/activate_contract_res.dart';
import '../../models/contracts/active_contract_model.dart';
import '../../models/contracts/all_contract_model.dart';
import '../../models/contracts/cancel_contract_res.dart';
import '../../models/contracts/complete_contract_res.dart';
import '../../models/contracts/create_contract_req.dart';
import '../../models/contracts/create_contract_res.dart';
import '../../models/contracts/delete_contract_res.dart';
import '../../models/contracts/end_contract_res.dart';
import '../../models/contracts/get_contract_by_id_res.dart';
import '../../models/contracts/pause_contract_res.dart';
import '../../models/contracts/paused_contract_model.dart';
import '../../models/contracts/update_contract_request.dart';
import '../../models/contracts/update_contract_response.dart';
import '../../models/contracts/update_payment_status_request.dart';
import '../../models/contracts/update_payment_status_response.dart';
import '../../models/contracts/user_contract_model.dart';

class ContractRemoteDataSource {
  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);

  /// Fetch contracts by status
  /// status: 'active', 'completed', 'paused', 'cancelled'
  Future<List<AllContractModel>> getContractsByStatus(String status) async {
    try {
      final response = await apiClient.get(
        '${ApiPath.getAllContracts}?status=$status',
      );

      switch (response.statusCode) {
        case 200:
          final List<dynamic> data = response.data is List
              ? response.data
              : response.data['data'] ?? [];
          return data
              .map((e) => AllContractModel.fromJson(e as Map<String, dynamic>))
              .toList();
        case 400:
          throw Exception("Invalid status parameter");
        case 401:
          throw Exception("Unauthorized - User not authenticated");
        case 500:
          throw Exception(
            response.data['error'] ?? 'Server error while fetching contracts',
          );
        default:
          throw Exception('Unexpected error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching contracts by status: $e');
    }
  }

  Future<ActivateContractResponse> activateContract(String contractId) async {
    final response = await apiClient.patch(
        ApiPath.activateContract(contractId)
    );

    switch (response.statusCode) {
      case 200:
        return ActivateContractResponse.fromJson(response.data);
      case 400:
        throw Exception("Invalid contract ID format");
      case 404:
        throw Exception("Contract not found");
      default:
        throw Exception(response.data['error'] ?? "Server error");
    }
  }

  Future<CancelContractResponse> cancelContract(String contractId) async {
    final response = await apiClient.put(
      endpoint: '/api/contracts/$contractId/cancel',
    );

    if (response.statusCode == 200) {
      return CancelContractResponse.fromJson(response.data['data']);
    } else if (response.statusCode == 404) {
      throw Exception(response.data['message'] ?? "Contract not found");
    } else if (response.statusCode == 500) {
      throw Exception(
        response.data['error'] ?? "Server error while cancelling contract",
      );
    } else {
      throw Exception(
        'Cancel contract failed with status code: ${response.statusCode}',
      );
    }
  }

  Future<CompleteContractResponse> completeContract(String contractId) async {
    final response = await apiClient.patch(
      ApiPath.completeContract(contractId),
    );

    if (response.statusCode == 200) {
      return CompleteContractResponse.fromJson(response.data);
    } else if (response.statusCode == 400 || response.statusCode == 404) {
      throw Exception(response.data['message'] ?? 'Contract not found or invalid');
    } else if (response.statusCode == 500) {
      throw Exception(response.data['error'] ?? 'Server error while completing contract');
    } else {
      throw Exception(
        'Complete contract failed with status code: ${response.statusCode}',
      );
    }
  }

  Future<CreateContractResponse> createContract(CreateContractRequest request) async {
    final response = await apiClient.post(
      endpoint: ApiPath.createContract,
      data: request.toJson(),
    );

    if (response.statusCode == 201) {
      return CreateContractResponse.fromJson(response.data);
    } else if (response.statusCode == 400) {
      throw Exception(response.data['message'] ?? 'Validation error');
    } else if (response.statusCode == 500) {
      throw Exception(response.data['message'] ?? 'Failed to create contract');
    } else {
      throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<DeleteContractResponse> deleteContract(String contractId) async {
    final response = await apiClient.delete(endpoint: ApiPath.deleteContract(contractId));

    if (response.statusCode == 200) {
      return DeleteContractResponse.fromJson(response.data);
    } else if (response.statusCode == 404) {
      throw Exception(response.data['message'] ?? "Contract not found");
    } else {
      throw Exception(response.data['message'] ?? "Failed to delete contract");
    }
  }

  Future<GetContractByIdResponse> getContractById(String contractId) async {
    final response = await apiClient.get(ApiPath.getContractById(contractId));

    switch (response.statusCode) {
      case 200:
        return GetContractByIdResponse.fromJson(response.data);
      case 404:
        throw Exception("Contract not found");
      case 500:
        throw Exception(response.data['error'] ?? "Internal Server Error");
      default:
        throw Exception("Failed to fetch contract");
    }
  }

  Future<EndContractResponse> endContract(String contractId) async {
    final response = await apiClient.put(
      endpoint: ApiPath.endContract(contractId),
    );

    switch (response.statusCode) {
      case 200:
        return EndContractResponse.fromJson(response.data);
      case 404:
        throw Exception("Contract not found");
      case 500:
        throw Exception(response.data['message'] ?? "Server error");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }

  Future<List<ActiveContractModel>> getActiveContracts() async {
    final response = await apiClient.get(ApiPath.getActiveContracts);

    switch (response.statusCode) {
      case 200:
        return (response.data as List)
            .map((e) => ActiveContractModel.fromJson(e))
            .toList();
      case 401:
        throw Exception("Unauthorized - User not authenticated");
      case 500:
        throw Exception(response.data['error'] ?? "Server error");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }

  Future<List<AllContractModel>> getAllContracts() async {
    final response = await apiClient.get(ApiPath.getAllContracts);

    switch (response.statusCode) {
      case 200:
        return (response.data as List)
            .map((e) => AllContractModel.fromJson(e))
            .toList();
      case 500:
        throw Exception(response.data['error'] ?? 'Server error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<List<AllContractModel>> getCanceledContracts() async {
    final response = await apiClient.get(ApiPath.getCanceledContracts);

    switch (response.statusCode) {
      case 200:
        return (response.data as List)
            .map((e) => AllContractModel.fromJson(e))
            .toList();
      case 401:
        throw Exception("Unauthorized access");
      case 500:
        throw Exception(response.data['error'] ?? 'Server error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<List<AllContractModel>> getCompletedContracts() async {
    final response = await apiClient.get(ApiPath.getCompletedContracts);

    switch (response.statusCode) {
      case 200:
        return (response.data as List)
            .map((e) => AllContractModel.fromJson(e))
            .toList();
      case 401:
        throw Exception("Unauthorized access");
      case 500:
        throw Exception(response.data['error'] ?? 'Server error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<List<AllContractModel>> getContractsByJobId(String jobId) async {
    final response = await apiClient.get(ApiPath.getContractsByJobId(jobId));

    switch (response.statusCode) {
      case 200:
        return (response.data['data'] as List)
            .map((e) => AllContractModel.fromJson(e))
            .toList();
      case 400:
        throw Exception("Invalid job ID format.");
      case 404:
        throw Exception("No contracts found for the given job ID.");
      case 500:
        throw Exception(response.data['error'] ?? "Server error");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }

  Future<List<UserContractModel>> getContractsByUserId(String userId) async {
    final response = await apiClient.get(ApiPath.getContractsByUserId(userId));

    switch (response.statusCode) {
      case 200:
        return (response.data['data'] as List)
            .map((e) => UserContractModel.fromJson(e))
            .toList();
      case 500:
        throw Exception(response.data['error'] ?? 'Failed to fetch contracts');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<List<AllContractModel>> getEndedContracts() async {
    final response = await apiClient.get(ApiPath.getEndedContracts);

    switch (response.statusCode) {
      case 200:
        return (response.data as List)
            .map((e) => AllContractModel.fromJson(e))
            .toList();
      case 401:
        throw Exception('Unauthorized - User not authenticated');
      case 500:
        throw Exception(response.data['error'] ?? 'Server error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<List<PausedContractModel>> getPausedContracts(String userId) async {
    final response = await apiClient.get(ApiPath.getPausedContracts(userId));

    switch (response.statusCode) {
      case 200:
        return (response.data as List)
            .map((e) => PausedContractModel.fromJson(e))
            .toList();
      case 400:
        throw Exception('Invalid user ID');
      case 500:
        throw Exception(response.data['error'] ?? 'Server error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<PauseContractResponse> pauseContract(String contractId) async {
    final response = await apiClient.patch(
      ApiPath.pauseContract(contractId),
    );

    switch (response.statusCode) {
      case 200:
        return PauseContractResponse.fromJson(response.data);
      case 400:
        throw Exception("Invalid contract ID format");
      case 404:
        throw Exception("Contract not found");
      case 500:
        throw Exception(response.data['error'] ?? "Server error");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }

  Future<UpdateContractResponse> updateContract(
      String id,
      UpdateContractRequest request,
      ) async {
    final response = await apiClient.put(
      endpoint: ApiPath.updateContract(id),
      data: request.toJson(),
    );

    switch (response.statusCode) {
      case 200:
        return UpdateContractResponse.fromJson(response.data);
      case 400:
        throw Exception("Validation error: ${response.data['message']}");
      case 403:
        throw Exception("Unauthorized to update this contract");
      case 404:
        throw Exception("Contract not found");
      case 500:
        throw Exception("Failed to update contract");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }

  Future<UpdatePaymentStatusResponse> updatePaymentStatus(
      String contractId,
      UpdatePaymentStatusRequest request,
      ) async {
    final response = await apiClient.put(
      endpoint: ApiPath.updateContractPayment(contractId),
      data: request.toJson(),
    );

    switch (response.statusCode) {
      case 200:
        return UpdatePaymentStatusResponse.fromJson(response.data);
      case 400:
        throw Exception("Invalid payment status");
      case 404:
        throw Exception("Contract not found");
      case 500:
        throw Exception("Failed to update payment status");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }
}

// // data/data_source/remote/contract_remote_data_source.dart
//
// import 'package:dio/dio.dart';
// import '../../../core/constants/api_endpoints.dart';
// import '../../../core/network/api_client.dart';
// import '../../models/contracts/activate_contract_res.dart';
// import '../../models/contracts/active_contract_model.dart';
// import '../../models/contracts/all_contract_model.dart';
// import '../../models/contracts/cancel_contract_res.dart';
// import '../../models/contracts/complete_contract_res.dart';
// import '../../models/contracts/create_contract_req.dart';
// import '../../models/contracts/create_contract_res.dart';
// import '../../models/contracts/delete_contract_res.dart';
// import '../../models/contracts/end_contract_res.dart';
// import '../../models/contracts/get_contract_by_id_res.dart';
// import '../../models/contracts/pause_contract_res.dart';
// import '../../models/contracts/paused_contract_model.dart';
// import '../../models/contracts/update_contract_request.dart';
// import '../../models/contracts/update_contract_response.dart';
// import '../../models/contracts/update_payment_status_request.dart';
// import '../../models/contracts/update_payment_status_response.dart';
// import '../../models/contracts/user_contract_model.dart';
//
// class ContractRemoteDataSource {
//   final ApiClient apiClient = ApiClient(ApiPath.baseUrl);
//
//
//   Future<ActivateContractResponse> activateContract(String contractId) async {
//     final response = await apiClient.patch(
//         ApiPath.activateContract(contractId)
//     );
//
//     switch (response.statusCode) {
//       case 200:
//         return ActivateContractResponse.fromJson(response.data);
//       case 400:
//         throw Exception("Invalid contract ID format");
//       case 404:
//         throw Exception("Contract not found");
//       default:
//         throw Exception(response.data['error'] ?? "Server error");
//     }
//   }
//
//   Future<CancelContractResponse> cancelContract(String contractId) async {
//     final response = await apiClient.put(
//       endpoint: '/api/contracts/$contractId/cancel',
//     );
//
//     if (response.statusCode == 200) {
//       return CancelContractResponse.fromJson(response.data['data']);
//     } else if (response.statusCode == 404) {
//       throw Exception(response.data['message'] ?? "Contract not found");
//     } else if (response.statusCode == 500) {
//       throw Exception(
//         response.data['error'] ?? "Server error while cancelling contract",
//       );
//     } else {
//       throw Exception(
//         'Cancel contract failed with status code: ${response.statusCode}',
//       );
//     }
//   }
//
//
//   Future<CompleteContractResponse> completeContract(String contractId) async {
//     final response = await apiClient.patch(
//       ApiPath.completeContract(contractId),
//     );
//
//     if (response.statusCode == 200) {
//       return CompleteContractResponse.fromJson(response.data);
//     } else if (response.statusCode == 400 || response.statusCode == 404) {
//       throw Exception(response.data['message'] ?? 'Contract not found or invalid');
//     } else if (response.statusCode == 500) {
//       throw Exception(response.data['error'] ?? 'Server error while completing contract');
//     } else {
//       throw Exception(
//         'Complete contract failed with status code: ${response.statusCode}',
//       );
//     }
//   }
//
//   Future<CreateContractResponse> createContract(CreateContractRequest request) async {
//     final response = await apiClient.post(
//       endpoint: ApiPath.createContract,
//       data: request.toJson(),
//     );
//
//     if (response.statusCode == 201) {
//       return CreateContractResponse.fromJson(response.data);
//     } else if (response.statusCode == 400) {
//       throw Exception(response.data['message'] ?? 'Validation error');
//     } else if (response.statusCode == 500) {
//       throw Exception(response.data['message'] ?? 'Failed to create contract');
//     } else {
//       throw Exception('Unexpected error: ${response.statusCode}');
//     }
//   }
//
//   Future<DeleteContractResponse> deleteContract(String contractId) async {
//     final response = await apiClient.delete(endpoint: ApiPath.deleteContract(contractId));
//
//     if (response.statusCode == 200) {
//       return DeleteContractResponse.fromJson(response.data);
//     } else if (response.statusCode == 404) {
//       throw Exception(response.data['message'] ?? "Contract not found");
//     } else {
//       throw Exception(response.data['message'] ?? "Failed to delete contract");
//     }
//   }
//
//   Future<GetContractByIdResponse> getContractById(String contractId) async {
//     final response = await apiClient.get(ApiPath.getContractById(contractId));
//
//     switch (response.statusCode) {
//       case 200:
//         return GetContractByIdResponse.fromJson(response.data);
//       case 404:
//         throw Exception("Contract not found");
//       case 500:
//         throw Exception(response.data['error'] ?? "Internal Server Error");
//       default:
//         throw Exception("Failed to fetch contract");
//     }
//   }
//
//   Future<EndContractResponse> endContract(String contractId) async {
//     final response = await apiClient.put(
//       endpoint: ApiPath.endContract(contractId),
//     );
//
//     switch (response.statusCode) {
//       case 200:
//         return EndContractResponse.fromJson(response.data);
//       case 404:
//         throw Exception("Contract not found");
//       case 500:
//         throw Exception(response.data['message'] ?? "Server error");
//       default:
//         throw Exception("Unexpected error: ${response.statusCode}");
//     }
//   }
//
//
//   Future<List<ActiveContractModel>> getActiveContracts() async {
//     final response = await apiClient.get(ApiPath.getActiveContracts);
//
//     switch (response.statusCode) {
//       case 200:
//         return (response.data as List)
//             .map((e) => ActiveContractModel.fromJson(e))
//             .toList();
//       case 401:
//         throw Exception("Unauthorized - User not authenticated");
//       case 500:
//         throw Exception(response.data['error'] ?? "Server error");
//       default:
//         throw Exception("Unexpected error: ${response.statusCode}");
//     }
//   }
//
//   Future<List<AllContractModel>> getAllContracts() async {
//     final response = await apiClient.get(ApiPath.getAllContracts);
//
//     switch (response.statusCode) {
//       case 200:
//         return (response.data as List)
//             .map((e) => AllContractModel.fromJson(e))
//             .toList();
//       case 500:
//         throw Exception(response.data['error'] ?? 'Server error');
//       default:
//         throw Exception('Unexpected error: ${response.statusCode}');
//     }
//   }
//
//   Future<List<AllContractModel>> getCanceledContracts() async {
//     final response = await apiClient.get(ApiPath.getCanceledContracts);
//
//     switch (response.statusCode) {
//       case 200:
//         return (response.data as List)
//             .map((e) => AllContractModel.fromJson(e))
//             .toList();
//       case 401:
//         throw Exception("Unauthorized access");
//       case 500:
//         throw Exception(response.data['error'] ?? 'Server error');
//       default:
//         throw Exception('Unexpected error: ${response.statusCode}');
//     }
//   }
//
//   // ✅ GET completed contracts
//   Future<List<AllContractModel>> getCompletedContracts() async {
//     final response = await apiClient.get(ApiPath.getCompletedContracts);
//
//     switch (response.statusCode) {
//       case 200:
//         return (response.data as List)
//             .map((e) => AllContractModel.fromJson(e))
//             .toList();
//       case 401:
//         throw Exception("Unauthorized access");
//       case 500:
//         throw Exception(response.data['error'] ?? 'Server error');
//       default:
//         throw Exception('Unexpected error: ${response.statusCode}');
//     }
//   }
//
//   Future<List<AllContractModel>> getContractsByJobId(String jobId) async {
//     final response = await apiClient.get(ApiPath.getContractsByJobId(jobId));
//
//     switch (response.statusCode) {
//       case 200:
//         return (response.data['data'] as List)
//             .map((e) => AllContractModel.fromJson(e))
//             .toList();
//       case 400:
//         throw Exception("Invalid job ID format.");
//       case 404:
//         throw Exception("No contracts found for the given job ID.");
//       case 500:
//         throw Exception(response.data['error'] ?? "Server error");
//       default:
//         throw Exception("Unexpected error: ${response.statusCode}");
//     }
//   }
//
//   Future<List<UserContractModel>> getContractsByUserId(String userId) async {
//     final response = await apiClient.get(ApiPath.getContractsByUserId(userId));
//
//     switch (response.statusCode) {
//       case 200:
//         return (response.data['data'] as List)
//             .map((e) => UserContractModel.fromJson(e))
//             .toList();
//       case 500:
//         throw Exception(response.data['error'] ?? 'Failed to fetch contracts');
//       default:
//         throw Exception('Unexpected error: ${response.statusCode}');
//     }
//   }
//
//
//   Future<List<AllContractModel>> getEndedContracts() async {
//     final response = await apiClient.get(ApiPath.getEndedContracts);
//
//     switch (response.statusCode) {
//       case 200:
//         return (response.data as List)
//             .map((e) => AllContractModel.fromJson(e))
//             .toList();
//       case 401:
//         throw Exception('Unauthorized - User not authenticated');
//       case 500:
//         throw Exception(response.data['error'] ?? 'Server error');
//       default:
//         throw Exception('Unexpected error: ${response.statusCode}');
//     }
//   }
//
//   Future<List<PausedContractModel>> getPausedContracts(String userId) async {
//     final response = await apiClient.get(ApiPath.getPausedContracts(userId));
//
//     switch (response.statusCode) {
//       case 200:
//         return (response.data as List)
//             .map((e) => PausedContractModel.fromJson(e))
//             .toList();
//       case 400:
//         throw Exception('Invalid user ID');
//       case 500:
//         throw Exception(response.data['error'] ?? 'Server error');
//       default:
//         throw Exception('Unexpected error: ${response.statusCode}');
//     }
//   }
//
//   Future<PauseContractResponse> pauseContract(String contractId) async {
//     final response = await apiClient.patch(
//       ApiPath.pauseContract(contractId),
//     );
//
//     switch (response.statusCode) {
//       case 200:
//         return PauseContractResponse.fromJson(response.data);
//       case 400:
//         throw Exception("Invalid contract ID format");
//       case 404:
//         throw Exception("Contract not found");
//       case 500:
//         throw Exception(response.data['error'] ?? "Server error");
//       default:
//         throw Exception("Unexpected error: ${response.statusCode}");
//     }
//   }
//
//
//   Future<UpdateContractResponse> updateContract(
//       String id,
//       UpdateContractRequest request,
//       ) async {
//     final response = await apiClient.put(
//       endpoint: ApiPath.updateContract(id),
//       data: request.toJson(),
//     );
//
//     switch (response.statusCode) {
//       case 200:
//         return UpdateContractResponse.fromJson(response.data);
//       case 400:
//         throw Exception("Validation error: ${response.data['message']}");
//       case 403:
//         throw Exception("Unauthorized to update this contract");
//       case 404:
//         throw Exception("Contract not found");
//       case 500:
//         throw Exception("Failed to update contract");
//       default:
//         throw Exception("Unexpected error: ${response.statusCode}");
//     }
//   }
//
//   Future<UpdatePaymentStatusResponse> updatePaymentStatus(
//       String contractId,
//       UpdatePaymentStatusRequest request,
//       ) async {
//     final response = await apiClient.put(
//       endpoint: ApiPath.updateContractPayment(contractId),
//       data: request.toJson(),
//     );
//
//     switch (response.statusCode) {
//       case 200:
//         return UpdatePaymentStatusResponse.fromJson(response.data);
//       case 400:
//         throw Exception("Invalid payment status");
//       case 404:
//         throw Exception("Contract not found");
//       case 500:
//         throw Exception("Failed to update payment status");
//       default:
//         throw Exception("Unexpected error: ${response.statusCode}");
//     }
//   }
// }