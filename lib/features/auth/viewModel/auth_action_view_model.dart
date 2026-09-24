import 'package:flutter/material.dart';
import '../repository/auth_repository.dart';
import '../model/auth_models.dart';

class AuthActionViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _successMessage;
  String? get successMessage => _successMessage;

  Future<bool> verifyEmail(String email, String token) async {
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    final response = await _authRepository.verifyEmail(VerifyEmailRequest(email: email, token: token));
    
    _isLoading = false;
    if (response.success) {
      _successMessage = response.message;
      notifyListeners();
      return true;
    } else {
      _errorMessage = response.message;
      notifyListeners();
      return false;
    }
  }

  Future<bool> resendVerificationEmail(String email) async {
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    final response = await _authRepository.resendVerificationEmail(email);
    
    _isLoading = false;
    if (response.success) {
      _successMessage = response.message;
      notifyListeners();
      return true;
    } else {
      _errorMessage = response.message;
      notifyListeners();
      return false;
    }
  }

  Future<bool> forgotPassword(String email) async {
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    final response = await _authRepository.forgotPassword(email);
    
    _isLoading = false;
    if (response.success) {
      _successMessage = response.message;
      notifyListeners();
      return true;
    } else {
      _errorMessage = response.message;
      notifyListeners();
      return false;
    }
  }

  Future<bool> resetPassword(String email, String token, String newPassword) async {
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    final response = await _authRepository.resetPassword(
      ResetPasswordRequest(email: email, token: token, password: newPassword),
    );
    
    _isLoading = false;
    if (response.success) {
      _successMessage = response.message;
      notifyListeners();
      return true;
    } else {
      _errorMessage = response.message;
      notifyListeners();
      return false;
    }
  }
}
