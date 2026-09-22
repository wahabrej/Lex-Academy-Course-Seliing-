import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constant/ApiEndPoint.dart';
import '../model/login_model.dart';
import '../model/register_model.dart';
import '../model/user_model.dart';

class AuthRepository {
  Future<RegisterResponse> register(RegisterRequest request) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndPoint.register),
        headers: {'Content-Type': 'application/json', 'accept': '*/*'},
        body: jsonEncode(request.toJson()),
      );

      final Map<String, dynamic> data = jsonDecode(response.body);
      return RegisterResponse.fromJson(data);
    } catch (e) {
      return RegisterResponse(success: false, message: e.toString());
    }
  }

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndPoint.login),
        headers: {'Content-Type': 'application/json', 'accept': '*/*'},
        body: jsonEncode(request.toJson()),
      );

      final Map<String, dynamic> data = jsonDecode(response.body);
      return LoginResponse.fromJson(data);
    } catch (e) {
      return LoginResponse(success: false, message: e.toString());
    }
  }

  Future<UserResponse> getMe(String token) async {
    try {
      final response = await http.get(
        Uri.parse(ApiEndPoint.me),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $token',
        },
      );

      final Map<String, dynamic> data = jsonDecode(response.body);
      return UserResponse.fromJson(data);
    } catch (e) {
      return UserResponse(success: false);
    }
  }
}
