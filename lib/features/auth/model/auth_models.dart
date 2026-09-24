import 'dart:convert';

// --- Refresh Token ---
class RefreshTokenRequest {
  final String refreshToken;
  RefreshTokenRequest({required this.refreshToken});
  Map<String, dynamic> toJson() => {"refresh_token": refreshToken};
}

// --- Logout ---
class LogoutRequest {
  final String? sessionId;
  LogoutRequest({this.sessionId});
  Map<String, dynamic> toJson() => sessionId != null ? {"sessionId": sessionId} : {};
}

// --- Device Info ---
class DeviceInfo {
  final String id;
  final String deviceName;
  final String ipAddress;
  final DateTime expiresAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  DeviceInfo({
    required this.id,
    required this.deviceName,
    required this.ipAddress,
    required this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DeviceInfo.fromJson(Map<String, dynamic> json) => DeviceInfo(
        id: json["id"],
        deviceName: json["device_name"],
        ipAddress: json["ip_address"],
        expiresAt: DateTime.parse(json["expires_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}

class DevicesResponse {
  final bool success;
  final String message;
  final List<DeviceInfo> data;

  DevicesResponse({required this.success, required this.message, required this.data});

  factory DevicesResponse.fromJson(Map<String, dynamic> json) => DevicesResponse(
        success: json["success"],
        message: json["message"],
        data: List<DeviceInfo>.from(json["data"].map((x) => DeviceInfo.fromJson(x))),
      );
}

// --- Verify Email ---
class VerifyEmailRequest {
  final String email;
  final String token;
  VerifyEmailRequest({required this.email, required this.token});
  Map<String, dynamic> toJson() => {"email": email, "token": token};
}

// --- Password Management ---
class ForgotPasswordRequest {
  final String email;
  ForgotPasswordRequest({required this.email});
  Map<String, dynamic> toJson() => {"email": email};
}

class ResetPasswordRequest {
  final String email;
  final String token;
  final String password;
  ResetPasswordRequest({required this.email, required this.token, required this.password});
  Map<String, dynamic> toJson() => {"email": email, "token": token, "password": password};
}

class ChangePasswordRequest {
  final String oldPassword;
  final String newPassword;
  ChangePasswordRequest({required this.oldPassword, required this.newPassword});
  Map<String, dynamic> toJson() => {"old_password": oldPassword, "new_password": newPassword};
}

// --- Common Auth Response ---
class AuthCommonResponse {
  final bool success;
  final String message;
  AuthCommonResponse({required this.success, required this.message});
  factory AuthCommonResponse.fromJson(Map<String, dynamic> json) => AuthCommonResponse(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
      );
}
