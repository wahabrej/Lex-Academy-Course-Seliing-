class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final String phone;
  final String university;
  final String profession;
  final String gender;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.university,
    required this.profession,
    required this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
      "university": university,
      "profession": profession,
      "gender": gender,
    };
  }
}

class RegisterResponse {
  final bool success;
  final String message;

  RegisterResponse({required this.success, required this.message});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
