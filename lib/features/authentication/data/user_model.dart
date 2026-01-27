class UserModel {
  final String fullName;
  final String email;
  final String token;
  final String? profileImageUrl;

  UserModel({
    required this.fullName,
    required this.email,
    required this.token,
    required this.profileImageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json["fullName"],
      email: json["email"],
      token: json["token"],
      profileImageUrl: json["profileImageUrl"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName,
      "email": email,
      "token": token,
      "profileImageUrl": profileImageUrl,
    };
  }
}
