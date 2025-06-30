// certificate_provider.dart
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../data/models/certificate/add_certificate_req.dart';
import '../../../../../data/models/certificate/get_user_certificates_res.dart';
import '../../../../../data/models/certificate/update_certificate_req.dart';
import '../../../../../data/repositories/certificate_repository_impl.dart';
import '../../../../../domain/repository/certificate_repository.dart';
import '../../../../../utils/constants/colors.dart';



class CertificateProvider with ChangeNotifier {
  final CertificateRepository _repository = CertificateRepositoryImpl();

  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  List<Certificate> _certificates = [];

  List<Certificate> get certificates => _certificates;



  Future<void> addCertificate(BuildContext context, AddCertificateRequest request) async {
    context.loaderOverlay.show();
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _repository.addCertificate(request);

      Fluttertoast.showToast(
        msg: "Certificate added: ${response.certificateName}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(
        msg: _errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: JAppColors.error900,
        textColor: Colors.white,
      );
    } finally {
      context.loaderOverlay.hide();
      _isLoading = false;
      notifyListeners();
    }
  }



  Future<void> fetchUserCertificates(BuildContext context, String userId) async {
    context.loaderOverlay.show();
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _repository.getUserCertificates(userId);
      _certificates = response;
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(
        msg: _errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: JAppColors.error900,
        textColor: Colors.white,
      );
    } finally {
      context.loaderOverlay.hide();
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> deleteCertificate(BuildContext context, String certificateId) async {
    context.loaderOverlay.show();
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _repository.deleteCertificate(certificateId);
      Fluttertoast.showToast(
        msg: result.message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      _certificates.removeWhere((c) => c.id == certificateId);
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      context.loaderOverlay.hide();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateCertificate(BuildContext context, String id, UpdateCertificateRequest request) async {
    try {
      context.loaderOverlay.show();
      _isLoading = true;
      notifyListeners();

      final result = await _repository.updateCertificate(id, request);

      Fluttertoast.showToast(
        msg: "Certificate updated successfully",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      // Optional: Update in local list if needed
      final index = _certificates.indexWhere((c) => c.id == id);
      if (index != -1) {
        _certificates[index] = result as Certificate;
        notifyListeners();
      }

    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      context.loaderOverlay.hide();
      _isLoading = false;
      notifyListeners();
    }
  }
}
