import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_contracts/data/repositories/user_repository_impl.dart';
import 'package:job_contracts/domain/repository/user_repository.dart';

import '../../../../data/models/user/contractor_by_speciality_res.dart';
import '../../../../utils/constants/colors.dart';

class ContractorProvider with ChangeNotifier {
  final UserRepository _repository = UserRepositoryImpl();

  List<Contractor> _contractors = [];
  ContractorPaginationMeta? _meta;
  bool _isLoading = false;
  String _error = '';

  List<Contractor> get contractors => _contractors;
  bool get isLoading => _isLoading;
  String get error => _error;
  ContractorPaginationMeta? get pagination => _meta;

  Future<void> fetchContractors(String speciality, {int page = 1, int limit = 10}) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final result = await _repository.getContractorsBySpeciality(
        speciality: speciality,
        page: page,
        limit: limit,
      );
      _contractors = result.data;
      _meta = result.meta;
    } catch (e) {
      _error = e.toString();
      Fluttertoast.showToast(
        msg: _error,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: JAppColors.primary,
        textColor: Colors.white,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearContractors() {
    _contractors.clear();
    _meta = null;
    _error = '';
    notifyListeners();
  }
}
