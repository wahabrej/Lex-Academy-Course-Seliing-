import 'package:flutter/material.dart';
import '../../model/register_model.dart';
import '../../repository/auth_repository.dart';

class SignupViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Temporary storage for step 1
  String? name;
  String? email;
  String? password;
  String? phone;

  void setStep1Data({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    this.name = name;
    this.email = email;
    this.password = password;
    this.phone = phone;
    notifyListeners();
  }

  Future<bool> register({
    required String university,
    required String profession,
    required String gender,
  }) async {
    if (name == null || email == null || password == null || phone == null) {
      _errorMessage = "Basic information is missing. Please go back to step 1.";
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final request = RegisterRequest(
      name: name!,
      email: email!,
      password: password!,
      phone: phone!,
      university: university,
      profession: profession,
      gender: gender,
    );

    final response = await _authRepository.register(request);

    _isLoading = false;
    if (response.success) {
      notifyListeners();
      return true;
    } else {
      _errorMessage = response.message;
      notifyListeners();
      return false;
    }
  }
}
