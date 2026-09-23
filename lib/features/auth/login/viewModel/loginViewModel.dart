import 'package:flutter/material.dart';
import '../../../../core/constant/TokenStorage.dart';
import '../../model/login_model.dart';
import '../../repository/auth_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  final AppStorage _storage = AppStorage();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final request = LoginRequest(email: email, password: password);
    final response = await _authRepository.login(request);

    _isLoading = false;
    if (response.success && response.authorization != null) {
      await _storage.saveToken(response.authorization!.accessToken);
      if (response.role != null) {
        await _storage.saveUserRole(response.role!);
      }
      await _storage.saveUserEmail(email);
      notifyListeners();
      return true;
    } else {
      _errorMessage = response.message;
      notifyListeners();
      return false;
    }
  }
}
