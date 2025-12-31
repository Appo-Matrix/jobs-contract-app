// domain/repository/contract_repository.dart

import '../../data/models/contracts/activate_contract_res.dart';
import '../../data/models/contracts/active_contract_model.dart';
import '../../data/models/contracts/all_contract_model.dart';
import '../../data/models/contracts/cancel_contract_res.dart';
import '../../data/models/contracts/complete_contract_res.dart';
import '../../data/models/contracts/create_contract_req.dart';
import '../../data/models/contracts/create_contract_res.dart';
import '../../data/models/contracts/delete_contract_res.dart';
import '../../data/models/contracts/end_contract_res.dart';
import '../../data/models/contracts/get_contract_by_id_res.dart';
import '../../data/models/contracts/pause_contract_res.dart';
import '../../data/models/contracts/paused_contract_model.dart';
import '../../data/models/contracts/update_contract_request.dart';
import '../../data/models/contracts/update_contract_response.dart';
import '../../data/models/contracts/update_payment_status_request.dart';
import '../../data/models/contracts/update_payment_status_response.dart';
import '../../data/models/contracts/user_contract_model.dart';

abstract class ContractRepository {

  Future<List<AllContractModel>> getContractsByStatus(String status);

  Future<ActivateContractResponse> activateContract(String contractId);

  Future<CancelContractResponse> cancelContract(String contractId);

  Future<CompleteContractResponse> completeContract(String contractId);

  Future<CreateContractResponse> createContract(CreateContractRequest request);

  Future<DeleteContractResponse> deleteContract(String contractId);

  Future<GetContractByIdResponse> getContractById(String contractId);

  Future<EndContractResponse> endContract(String contractId);

  Future<List<ActiveContractModel>> getActiveContracts();

  Future<List<AllContractModel>> getAllContracts();

  Future<List<AllContractModel>> getCanceledContracts();

  Future<List<AllContractModel>> getCompletedContracts();

  Future<List<AllContractModel>> getContractsByJobId(String jobId);

  Future<List<UserContractModel>> getContractsByUserId(String userId);

  Future<List<AllContractModel>> getEndedContracts();

  Future<List<PausedContractModel>> getPausedContracts(String userId);

  Future<PauseContractResponse> pauseContract(String contractId);

  Future<UpdateContractResponse> updateContract(String id, UpdateContractRequest request);

  Future<UpdatePaymentStatusResponse> updatePaymentStatus(String contractId, UpdatePaymentStatusRequest request,);



}
