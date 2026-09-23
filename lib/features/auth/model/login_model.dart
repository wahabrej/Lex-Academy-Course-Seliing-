class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }
}

class LoginResponse {
  final bool success;
  final String message;
  final Authorization? authorization;
  final String? role;

  LoginResponse({
    required this.success,
    required this.message,
    this.authorization,
    this.role,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      authorization: json['authorization'] != null
          ? Authorization.fromJson(json['authorization'])
          : null,
      role: json['role'],
    );
  }
}

class Authorization {
  final String type;
  final String accessToken;
  final String refreshToken;

  Authorization({
    required this.type,
    required this.accessToken,
    required this.refreshToken,
  });

  factory Authorization.fromJson(Map<String, dynamic> json) {
    return Authorization(
      type: json['type'] ?? '',
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
    );
  }
}
