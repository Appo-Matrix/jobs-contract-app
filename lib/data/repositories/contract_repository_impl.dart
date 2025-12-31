// data/repositories/contract_repository_impl.dart

import '../../domain/repository/contract_repository.dart';
import '../data_source/remote/contracts_rds.dart';
import '../models/contracts/activate_contract_res.dart';
import '../models/contracts/active_contract_model.dart';
import '../models/contracts/all_contract_model.dart';
import '../models/contracts/cancel_contract_res.dart';
import '../models/contracts/complete_contract_res.dart';
import '../models/contracts/create_contract_req.dart';
import '../models/contracts/create_contract_res.dart';
import '../models/contracts/delete_contract_res.dart';
import '../models/contracts/end_contract_res.dart';
import '../models/contracts/get_contract_by_id_res.dart';
import '../models/contracts/pause_contract_res.dart';
import '../models/contracts/paused_contract_model.dart';
import '../models/contracts/update_contract_request.dart';
import '../models/contracts/update_contract_response.dart';
import '../models/contracts/update_payment_status_request.dart';
import '../models/contracts/update_payment_status_response.dart';
import '../models/contracts/user_contract_model.dart';

class ContractRepositoryImpl implements ContractRepository {
  final ContractRemoteDataSource remoteDataSource = ContractRemoteDataSource();

  @override
  Future<List<AllContractModel>> getContractsByStatus(String status) async {
    try {
      return await remoteDataSource.getContractsByStatus(status);
    } catch (e) {
      throw Exception('Error fetching contracts by status: $e');
    }
  }

  @override
  Future<ActivateContractResponse> activateContract(String contractId) async {
    try {
      return await remoteDataSource.activateContract(contractId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CancelContractResponse> cancelContract(String contractId) async {
    try {
      return await remoteDataSource.cancelContract(contractId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CompleteContractResponse> completeContract(String contractId) async {
    try {
      return await remoteDataSource.completeContract(contractId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CreateContractResponse> createContract(CreateContractRequest request) async {
    try {
      return await remoteDataSource.createContract(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DeleteContractResponse> deleteContract(String contractId) async {
    try {
      return await remoteDataSource.deleteContract(contractId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GetContractByIdResponse> getContractById(String contractId) async {
    try {
      return await remoteDataSource.getContractById(contractId);
    } catch (error) {
      throw Exception('Error in repository during fetching contract by ID: $error');
    }
  }

  @override
  Future<EndContractResponse> endContract(String contractId) async {
    try {
      return await remoteDataSource.endContract(contractId);
    } catch (error) {
      throw Exception('Error in repository while ending contract: $error');
    }
  }

  @override
  Future<List<ActiveContractModel>> getActiveContracts() async {
    try {
      return await remoteDataSource.getActiveContracts();
    } catch (error) {
      throw Exception('Error in repository while fetching active contracts: $error');
    }
  }

  @override
  Future<List<AllContractModel>> getAllContracts() async {
    try {
      return await remoteDataSource.getAllContracts();
    } catch (error) {
      throw Exception('Error in repository while fetching all contracts: $error');
    }
  }

  @override
  Future<List<AllContractModel>> getCanceledContracts() async {
    try {
      return await remoteDataSource.getCanceledContracts();
    } catch (error) {
      throw Exception('Error in repository while fetching canceled contracts: $error');
    }
  }

  @override
  Future<List<AllContractModel>> getCompletedContracts() async {
    try {
      return await remoteDataSource.getCompletedContracts();
    } catch (error) {
      throw Exception('Error in repository while fetching completed contracts: $error');
    }
  }

  @override
  Future<List<AllContractModel>> getContractsByJobId(String jobId) async {
    try {
      return await remoteDataSource.getContractsByJobId(jobId);
    } catch (error) {
      throw Exception('Error in repository while fetching contracts by job ID: $error');
    }
  }

  @override
  Future<List<UserContractModel>> getContractsByUserId(String userId) async {
    try {
      return await remoteDataSource.getContractsByUserId(userId);
    } catch (error) {
      throw Exception('Error fetching contracts by user ID: $error');
    }
  }

  @override
  Future<List<AllContractModel>> getEndedContracts() async {
    try {
      return await remoteDataSource.getEndedContracts();
    } catch (error) {
      throw Exception('Error fetching ended contracts: $error');
    }
  }

  @override
  Future<List<PausedContractModel>> getPausedContracts(String userId) async {
    try {
      return await remoteDataSource.getPausedContracts(userId);
    } catch (error) {
      throw Exception('Error fetching paused contracts: $error');
    }
  }

  @override
  Future<PauseContractResponse> pauseContract(String contractId) async {
    try {
      return await remoteDataSource.pauseContract(contractId);
    } catch (error) {
      throw Exception('Error pausing contract: $error');
    }
  }

  @override
  Future<UpdateContractResponse> updateContract(
      String id,
      UpdateContractRequest request,
      ) async {
    try {
      return await remoteDataSource.updateContract(id, request);
    } catch (error) {
      throw Exception('Error updating contract: $error');
    }
  }

  @override
  Future<UpdatePaymentStatusResponse> updatePaymentStatus(
      String contractId,
      UpdatePaymentStatusRequest request,
      ) async {
    try {
      return await remoteDataSource.updatePaymentStatus(contractId, request);
    } catch (error) {
      throw Exception('Error updating payment status: $error');
    }
  }
}

// // data/repositories/contract_repository_impl.dart
//
// import 'package:job_contracts/data/data_source/remote/contracts_rds.dart';
//
// import '../../domain/repository/contract_repository.dart';
// import '../models/contracts/activate_contract_res.dart';
// import '../models/contracts/active_contract_model.dart';
// import '../models/contracts/all_contract_model.dart';
// import '../models/contracts/cancel_contract_res.dart';
// import '../models/contracts/complete_contract_res.dart';
// import '../models/contracts/create_contract_req.dart';
// import '../models/contracts/create_contract_res.dart';
// import '../models/contracts/delete_contract_res.dart';
// import '../models/contracts/end_contract_res.dart';
// import '../models/contracts/get_contract_by_id_res.dart';
// import '../models/contracts/pause_contract_res.dart';
// import '../models/contracts/paused_contract_model.dart';
// import '../models/contracts/update_contract_request.dart';
// import '../models/contracts/update_contract_response.dart';
// import '../models/contracts/update_payment_status_request.dart';
// import '../models/contracts/update_payment_status_response.dart';
// import '../models/contracts/user_contract_model.dart';
//
// class ContractRepositoryImpl implements ContractRepository {
//   final ContractRemoteDataSource remoteDataSource=  ContractRemoteDataSource();
//
//
//   @override
//   Future<ActivateContractResponse> activateContract(String contractId) async {
//     try {
//       return await remoteDataSource.activateContract(contractId);
//     }catch(e){
//       rethrow;
//     }
//   }
//
//   @override
//   Future<CancelContractResponse> cancelContract(String contractId) async{
//     try{
//
//       return await remoteDataSource.cancelContract(contractId);
//
//     }catch(e){
//       rethrow;
//     }
//   }
//
//   @override
//   Future<CompleteContractResponse> completeContract(String contractId) async{
//     try {
//       return await remoteDataSource.completeContract(contractId);
//     }catch(e){
//       rethrow;
//     }
//   }
//
//   @override
//   Future<CreateContractResponse> createContract(CreateContractRequest request) async {
//     try {
//       return  await remoteDataSource.createContract(request);
//     }catch(e){
//       rethrow;
//     }
//   }
//
//   @override
//   Future<DeleteContractResponse> deleteContract(String contractId) async {
//     try {
//       return await remoteDataSource.deleteContract(contractId);
//     }catch(e){
//       rethrow;
//     }
//   }
//
//   @override
//   Future<GetContractByIdResponse> getContractById(String contractId) async {
//     try {
//       return await remoteDataSource.getContractById(contractId);
//     } catch (error) {
//       throw Exception('Error in repository during fetching contract by ID: $error');
//     }
//   }
//
//   @override
//   Future<EndContractResponse> endContract(String contractId) async {
//     try {
//       return await remoteDataSource.endContract(contractId);
//     } catch (error) {
//       throw Exception('Error in repository while ending contract: $error');
//     }
//   }
//
//   @override
//   Future<List<ActiveContractModel>> getActiveContracts() async {
//     try {
//       return await remoteDataSource.getActiveContracts();
//     } catch (error) {
//       throw Exception('Error in repository while fetching active contracts: $error');
//     }
//   }
//
//
//   @override
//   Future<List<AllContractModel>> getAllContracts() async {
//     try {
//       return await remoteDataSource.getAllContracts();
//     } catch (error) {
//       throw Exception('Error in repository while fetching all contracts: $error');
//     }
//   }
//
//   @override
//   Future<List<AllContractModel>> getCanceledContracts() async {
//     try {
//       return await remoteDataSource.getCanceledContracts();
//     } catch (error) {
//       throw Exception('Error in repository while fetching canceled contracts: $error');
//     }
//   }
//
//   @override
//   Future<List<AllContractModel>> getCompletedContracts() async {
//     try {
//       return await remoteDataSource.getCompletedContracts();
//     } catch (error) {
//       throw Exception('Error in repository while fetching completed contracts: $error');
//     }
//   }
//
//   @override
//   Future<List<AllContractModel>> getContractsByJobId(String jobId) async {
//     try {
//       return await remoteDataSource.getContractsByJobId(jobId);
//     } catch (error) {
//       throw Exception('Error in repository while fetching contracts by job ID: $error');
//     }
//   }
//
//
//   @override
//   Future<List<UserContractModel>> getContractsByUserId(String userId) async {
//     try {
//       return await remoteDataSource.getContractsByUserId(userId);
//     } catch (error) {
//       throw Exception('Error fetching contracts by user ID: $error');
//     }
//   }
//
//   @override
//   Future<List<AllContractModel>> getEndedContracts() async {
//     try {
//       return await remoteDataSource.getEndedContracts();
//     } catch (error) {
//       throw Exception('Error fetching ended contracts: $error');
//     }
//   }
//
//   @override
//   Future<List<PausedContractModel>> getPausedContracts(String userId) async {
//     try {
//       return await remoteDataSource.getPausedContracts(userId);
//     } catch (error) {
//       throw Exception('Error fetching paused contracts: $error');
//     }
//   }
//
//   @override
//   Future<PauseContractResponse> pauseContract(String contractId) async {
//     try {
//       return await remoteDataSource.pauseContract(contractId);
//     } catch (error) {
//       throw Exception('Error pausing contract: $error');
//     }
//   }
//
//   @override
//   Future<UpdateContractResponse> updateContract(String id, UpdateContractRequest request) async {
//     try {
//       return await remoteDataSource.updateContract(id, request);
//     } catch (error) {
//       throw Exception('Error updating contract: $error');
//     }
//   }
//
//   @override
//   Future<UpdatePaymentStatusResponse> updatePaymentStatus(
//       String contractId,
//       UpdatePaymentStatusRequest request,
//       ) async {
//     try {
//       return await remoteDataSource.updatePaymentStatus(contractId, request);
//     } catch (error) {
//       throw Exception('Error updating payment status: $error');
//     }
//   }
// }
