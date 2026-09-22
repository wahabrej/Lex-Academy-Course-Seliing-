import 'package:flutter/material.dart';
import '../../../core/constant/TokenStorage.dart';
import '../../auth/model/user_model.dart';
import '../../auth/repository/auth_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  final AppStorage _storage = AppStorage();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserData? _userData;
  UserData? get userData => _userData;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchUserProfile() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final token = await _storage.getToken();
      if (token == null || token.isEmpty) {
        _errorMessage = "No token found. Please login again.";
        _isLoading = false;
        notifyListeners();
        return;
      }

      final response = await _authRepository.getMe(token);
      if (response.success && response.data != null) {
        _userData = response.data;
        // Optionally save name/email locally as well
        await _storage.saveUserName(response.data!.name);
        await _storage.saveUserEmail(response.data!.email);
      } else {
        _errorMessage = "Failed to fetch profile details";
      }
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    await _storage.clearAll();
    _userData = null;
    notifyListeners();
  }
}
