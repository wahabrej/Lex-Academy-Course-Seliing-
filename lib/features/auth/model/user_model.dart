class UserResponse {
  final bool success;
  final UserData? data;

  UserResponse({required this.success, this.data});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      success: json['success'] ?? false,
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }
}

class UserData {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? avatarUrl;
  final String phone;
  final String university;
  final String profession;
  final String gender;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.avatarUrl,
    required this.phone,
    required this.university,
    required this.profession,
    required this.gender,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      avatarUrl: json['avatar_url'],
      phone: json['phone'] ?? '',
      university: json['university'] ?? '',
      profession: json['profession'] ?? '',
      gender: json['gender'] ?? '',
    );
  }
}
