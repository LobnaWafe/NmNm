class MyChatsModel {
  final String userId;
  final String email;
  final String fullName;
  String? profileImage;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;

  MyChatsModel({
    required this.userId,
    required this.email,
    required this.fullName,
    required this.profileImage,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
  });

  // تحويل من JSON إلى Model
  factory MyChatsModel.fromJson(Map<String, dynamic> json) {
    return MyChatsModel(
      userId: json['userId'] ?? '',
      email: json['email'] ?? '',
      fullName: json['fullName'] ?? '',
      profileImage: json['profileImage'] ?? '',
      lastMessage: json['lastMessage'] ?? '',
      lastMessageTime: DateTime.parse(json['lastMessageTime']),
      unreadCount: json['unreadCount'] ?? 0,
    );
  }

  // تحويل من Model إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'fullName': fullName,
      'profileImage': profileImage,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime.toIso8601String(),
      'unreadCount': unreadCount,
    };
  }

  // وظيفة لتسهيل تحديث جزء معين من الموديل (مثل تصفير الـ unreadCount)
  MyChatsModel copyWith({
    String? userId,
    String? email,
    String? fullName,
    String? profileImage,
    String? lastMessage,
    DateTime? lastMessageTime,
    int? unreadCount,
  }) {
    return MyChatsModel(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      profileImage: profileImage ?? this.profileImage,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}