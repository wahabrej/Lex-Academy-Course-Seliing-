import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../../../core/constant/ApiEndPoint.dart';
import '../model/login_model.dart';
import '../model/register_model.dart';
import '../model/user_model.dart';
import '../model/auth_models.dart';

class AuthRepository {
  Future<Map<String, String>> _getHeaders({String? token}) async {
    final Map<String, String> headers = {
      'accept': '*/*',
      'Content-Type': 'application/json',
    };
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  Future<RegisterResponse> register(RegisterRequest request) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndPoint.register),
        headers: await _getHeaders(),
        body: jsonEncode(request.toJson()),
      );
      return RegisterResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      return RegisterResponse(success: false, message: e.toString());
    }
  }

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndPoint.login),
        headers: await _getHeaders(),
        body: jsonEncode(request.toJson()),
      );
      return LoginResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      return LoginResponse(success: false, message: e.toString());
    }
  }

  Future<UserResponse> getMe(String token) async {
    try {
      final response = await http.get(
        Uri.parse(ApiEndPoint.me),
        headers: await _getHeaders(token: token),
      );
      return UserResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      return UserResponse(success: false);
    }
  }

  Future<LoginResponse> refreshTokens(String refreshToken) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndPoint.refreshTokens),
        headers: await _getHeaders(),
        body: jsonEncode({"refresh_token": refreshToken}),
      );
      return LoginResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      return LoginResponse(success: false, message: e.toString());
    }
  }

  Future<AuthCommonResponse> logout(String token, {String? sessionId}) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndPoint.logout),
        headers: await _getHeaders(token: token),
        body: jsonEncode(sessionId != null ? {"sessionId": sessionId} : {}),
      );
      return AuthCommonResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      return AuthCommonResponse(success: false, message: e.toString());
    }
  }

  Future<DevicesResponse> getDevices(String token) async {
    try {
      final response = await http.get(
        Uri.parse(ApiEndPoint.devices),
        headers: await _getHeaders(token: token),
      );
      return DevicesResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      return DevicesResponse(success: false, message: e.toString(), data: []);
    }
  }

  Future<AuthCommonResponse> logoutAll(String token) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndPoint.logoutAll),
        headers: await _getHeaders(token: token),
      );
      return AuthCommonResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      return AuthCommonResponse(success: false, message: e.toString());
    }
  }

  Future<AuthCommonResponse> verifyEmail(VerifyEmailRequest request) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndPoint.verifyEmail),
        headers: await _getHeaders(),
        body: jsonEncode(request.toJson()),
      );
      return AuthCommonResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      return AuthCommonResponse(success: false, message: e.toString());
    }
  }

  Future<AuthCommonResponse> resendVerificationEmail(String email) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndPoint.resendVerificationEmail),
        headers: await _getHeaders(),
        body: jsonEncode({"email": email}),
      );
      return AuthCommonResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      return AuthCommonResponse(success: false, message: e.toString());
    }
  }

  Future<AuthCommonResponse> forgotPassword(String email) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndPoint.forgotPassword),
        headers: await _getHeaders(),
        body: jsonEncode({"email": email}),
      );
      return AuthCommonResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      return AuthCommonResponse(success: false, message: e.toString());
    }
  }

  Future<AuthCommonResponse> resetPassword(ResetPasswordRequest request) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndPoint.resetPassword),
        headers: await _getHeaders(),
        body: jsonEncode(request.toJson()),
      );
      return AuthCommonResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      return AuthCommonResponse(success: false, message: e.toString());
    }
  }

  Future<AuthCommonResponse> changePassword(String token, ChangePasswordRequest request) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndPoint.changePassword),
        headers: await _getHeaders(token: token),
        body: jsonEncode(request.toJson()),
      );
      return AuthCommonResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      return AuthCommonResponse(success: false, message: e.toString());
    }
  }

  Future<AuthCommonResponse> updateProfile(String token, {
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
    try {
      var request = http.MultipartRequest('PATCH', Uri.parse(ApiEndPoint.updateProfile));
      request.headers.addAll(await _getHeaders(token: token));
      
      if (name != null) request.fields['name'] = name;
      if (phone != null) request.fields['phone'] = phone;
      if (university != null) request.fields['university'] = university;
      if (profession != null) request.fields['profession'] = profession;
      if (gender != null) request.fields['gender'] = gender;
      if (designation != null) request.fields['designation'] = designation;
      if (credential != null) request.fields['credential'] = credential;
      if (bio != null) request.fields['bio'] = bio;
      if (facebook != null) request.fields['facebook'] = facebook;
      if (twitter != null) request.fields['twitter'] = twitter;
      if (instagram != null) request.fields['instagram'] = instagram;
      if (linkedin != null) request.fields['linkedin'] = linkedin;

      if (image != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          image.path,
          contentType: MediaType('image', 'jpeg'), // adjust accordingly
        ));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return AuthCommonResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      return AuthCommonResponse(success: false, message: e.toString());
    }
  }
}
