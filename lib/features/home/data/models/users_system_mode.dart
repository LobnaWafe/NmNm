class UsersSystemMode {
  final String id, email, fullName;
  String? profileImageUrl;
  UsersSystemMode({
    required this.id,
    required this.profileImageUrl,
    required this.email,
    required this.fullName,
  });

  factory UsersSystemMode.fromJson(Map<String, dynamic> json) {
    return UsersSystemMode(
      id: json["id"] ?? "",
      profileImageUrl: json["profileImageUrl"] ?? "",
      email: json["email"] ?? "",
      fullName: json["fullName"] ?? "",
    );
  }
}
