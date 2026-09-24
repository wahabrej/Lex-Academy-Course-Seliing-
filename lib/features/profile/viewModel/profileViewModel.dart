import 'dart:io';
import 'package:flutter/material.dart';
import '../../../core/constant/TokenStorage.dart';
import '../../auth/model/user_model.dart';
import '../../auth/model/auth_models.dart';
import '../../auth/repository/auth_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  final AppStorage _storage = AppStorage();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserData? _userData;
  UserData? get userData => _userData;

  List<DeviceInfo> _devices = [];
  List<DeviceInfo> get devices => _devices;

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

  Future<bool> updateProfile({
    String? name,
    String? phone,
    String? university,
    String? profession,
    String? gender,
    File? image,
    String? designation,
    String? credential,
    String? bio,
    String? facebook,
    String? twitter,
    String? instagram,
    String? linkedin,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final token = await _storage.getToken();
    if (token == null) return false;

    final response = await _authRepository.updateProfile(
      token,
      name: name,
      phone: phone,
      university: university,
      profession: profession,
      gender: gender,
      image: image,
      designation: designation,
      credential: credential,
      bio: bio,
      facebook: facebook,
      twitter: twitter,
      instagram: instagram,
      linkedin: linkedin,
    );

    if (response.success) {
      await fetchUserProfile(); // Refresh data
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _errorMessage = response.message;
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final token = await _storage.getToken();
    if (token == null) return false;

    final response = await _authRepository.changePassword(
      token,
      ChangePasswordRequest(oldPassword: oldPassword, newPassword: newPassword),
    );

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

  Future<void> fetchDevices() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final token = await _storage.getToken();
    if (token == null) return;

    final response = await _authRepository.getDevices(token);
    if (response.success) {
      _devices = response.data;
    } else {
      _errorMessage = response.message;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout({String? sessionId}) async {
    final token = await _storage.getToken();
    if (token != null) {
      await _authRepository.logout(token, sessionId: sessionId);
    }
    
    if (sessionId == null) {
      // Local logout if current session or no specific session
      await _storage.clearAll();
      _userData = null;
      _devices = [];
    } else {
      // Refresh devices if a specific session was removed
      await fetchDevices();
    }
    notifyListeners();
  }

  Future<void> logoutAll() async {
    final token = await _storage.getToken();
    if (token != null) {
      await _authRepository.logoutAll(token);
    }
    await _storage.clearAll();
    _userData = null;
    _devices = [];
    notifyListeners();
  }
}
