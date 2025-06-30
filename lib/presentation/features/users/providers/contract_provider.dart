// providers/contract_provider.dart

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_contracts/data/repositories/contract_repository_impl.dart';
import 'package:job_contracts/domain/repository/contract_repository.dart';
import '../../../../data/models/contracts/activate_contract_res.dart';
import '../../../../data/models/contracts/active_contract_model.dart';
import '../../../../data/models/contracts/all_contract_model.dart';
import '../../../../data/models/contracts/cancel_contract_res.dart';
import '../../../../data/models/contracts/complete_contract_res.dart';
import '../../../../data/models/contracts/create_contract_req.dart';
import '../../../../data/models/contracts/create_contract_res.dart';
import '../../../../data/models/contracts/delete_contract_res.dart';
import '../../../../data/models/contracts/end_contract_res.dart';
import '../../../../data/models/contracts/get_contract_by_id_res.dart';
import '../../../../data/models/contracts/pause_contract_res.dart';
import '../../../../data/models/contracts/paused_contract_model.dart';
import '../../../../data/models/contracts/update_contract_request.dart';
import '../../../../data/models/contracts/update_contract_response.dart';
import '../../../../data/models/contracts/update_payment_status_request.dart';
import '../../../../data/models/contracts/update_payment_status_response.dart';
import '../../../../data/models/contracts/user_contract_model.dart';

class ContractProvider with ChangeNotifier {
  final ContractRepository repository = ContractRepositoryImpl();


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  CancelContractResponse? response;


  ActivateContractResponse? _activateResponse;
  ActivateContractResponse? get activateResponse => _activateResponse;

  CompleteContractResponse? _completeResponse;
  CompleteContractResponse? get completeResponse => _completeResponse;

  Future<void> activateContract(String contractId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _activateResponse = await repository.activateContract(contractId);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }


  Future<void> cancelContract(BuildContext context, String contractId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await repository.cancelContract(contractId);
      response = result;

      Fluttertoast.showToast(
        msg: result.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  /// Complete a contract
  Future<void> completeContract(BuildContext context, String contractId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await repository.completeContract(contractId);
      _completeResponse = result;

      Fluttertoast.showToast(
        msg: result.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(
        msg: _errorMessage!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }

    _isLoading = false;
    notifyListeners();
  }


  CreateContractResponse? _createContractResponse;
  CreateContractResponse? get createContractResponse => _createContractResponse;

  Future<void> createContract(CreateContractRequest request) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _createContractResponse = await repository.createContract(request);
      Fluttertoast.showToast(
        msg: _createContractResponse!.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(
        msg: _errorMessage!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }

    _isLoading = false;
    notifyListeners();
  }


  DeleteContractResponse? _deleteResponse;
  DeleteContractResponse? get deleteResponse => _deleteResponse;

  Future<void> deleteContract(BuildContext context, String contractId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _deleteResponse = await repository.deleteContract(contractId);

      Fluttertoast.showToast(
        msg: _deleteResponse!.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(
        msg: _errorMessage!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }

    _isLoading = false;
    notifyListeners();
  }

  GetContractByIdResponse? _contractDetail;
  GetContractByIdResponse? get contractDetail => _contractDetail;

  Future<void> fetchContractById(String contractId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _contractDetail = await repository.getContractById(contractId);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }


  EndContractResponse? _endResponse;
  EndContractResponse? get endResponse => _endResponse;

  Future<void> endContract(String contractId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _endResponse = await repository.endContract(contractId);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  List<ActiveContractModel> _activeContracts = [];
  List<ActiveContractModel> get activeContracts => _activeContracts;

  Future<void> fetchActiveContracts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _activeContracts = await repository.getActiveContracts();
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }


  List<AllContractModel> _allContracts = [];
  List<AllContractModel> get allContracts => _allContracts;





  Future<void> fetchAllContracts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _allContracts = await repository.getAllContracts();
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  List<AllContractModel> _canceledContracts = [];
  List<AllContractModel> get canceledContracts => _canceledContracts;

  Future<void> fetchCanceledContracts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _canceledContracts = await repository.getCanceledContracts();
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  List<AllContractModel> _completedContracts = [];
  List<AllContractModel> get completedContracts => _completedContracts;



  Future<void> fetchCompletedContracts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _completedContracts = await repository.getCompletedContracts();
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  List<AllContractModel> _jobContracts = [];
  List<AllContractModel> get jobContracts => _jobContracts;



  Future<void> fetchContractsByJobId(String jobId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _jobContracts = await repository.getContractsByJobId(jobId);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }


  List<UserContractModel> _userContracts = [];
  List<UserContractModel> get userContracts => _userContracts;



  Future<void> fetchContractsByUserId(String userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _userContracts = await repository.getContractsByUserId(userId);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }


  List<AllContractModel> _endedContracts = [];
  List<AllContractModel> get endedContracts => _endedContracts;



  Future<void> fetchEndedContracts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _endedContracts = await repository.getEndedContracts();
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }



  List<PausedContractModel> _pausedContracts = [];
  List<PausedContractModel> get pausedContracts => _pausedContracts;



  Future<void> fetchPausedContracts(String userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _pausedContracts = await repository.getPausedContracts(userId);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  PauseContractResponse? _pauseResponse;
  PauseContractResponse? get pauseResponse => _pauseResponse;

  bool _isPausing = false;
  bool get isPausing => _isPausing;

  String? _pauseError;
  String? get pauseError => _pauseError;

  Future<void> pauseContract(String contractId) async {
    _isPausing = true;
    _pauseError = null;
    notifyListeners();

    try {
      _pauseResponse = await repository.pauseContract(contractId);
    } catch (e) {
      _pauseError = e.toString();
    }

    _isPausing = false;
    notifyListeners();
  }



  UpdateContractResponse? _updateContractResponse;
  UpdateContractResponse? get updateContractResponse => _updateContractResponse;

  bool _isUpdatingContract = false;
  bool get isUpdatingContract => _isUpdatingContract;

  String? _updateError;
  String? get updateError => _updateError;

  Future<void> updateContract(String id, UpdateContractRequest request) async {
    _isUpdatingContract = true;
    _updateError = null;
    notifyListeners();

    try {
      _updateContractResponse = await repository.updateContract(id, request);
    } catch (e) {
      _updateError = e.toString();
    }

    _isUpdatingContract = false;
    notifyListeners();
  }

  UpdatePaymentStatusResponse? _paymentStatusResponse;
  UpdatePaymentStatusResponse? get paymentStatusResponse => _paymentStatusResponse;

  bool _isUpdatingPayment = false;
  bool get isUpdatingPayment => _isUpdatingPayment;

  String? _paymentError;
  String? get paymentError => _paymentError;

  Future<void> updatePaymentStatus(
      String contractId,
      UpdatePaymentStatusRequest request,
      ) async {
    _isUpdatingPayment = true;
    _paymentError = null;
    notifyListeners();

    try {
      _paymentStatusResponse = await repository.updatePaymentStatus(contractId, request);
    } catch (e) {
      _paymentError = e.toString();
    }

    _isUpdatingPayment = false;
    notifyListeners();
  }
}
