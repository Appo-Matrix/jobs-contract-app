import 'package:flutter/cupertino.dart';

import '../../../../data/repositories/auth_repository_impl.dart';
import '../../../../domain/repository/auth_repository.dart';

class AuthProvider with ChangeNotifier{

  final AuthRepository authRepository = AuthRepositoryImpl();

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;


  void updateEmail(String email) {
    emailController.text = email;
    notifyListeners();
  }

  Future<void> loginWithEmail(BuildContext context) async {

  }

}