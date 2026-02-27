class MessageModel {
  final String id;
  final String content;
  final int messageType;
  final String senderId;
  final String receiverId;
  final DateTime sentAt;
  final DateTime? readAt;
  final int status;
  final double latitude;
  final double longitude;

  MessageModel({
    required this.id, required this.content, required this.messageType,
    required this.senderId, required this.receiverId, required this.sentAt,
    this.readAt, required this.status, required this.latitude, required this.longitude,
  });

  // 👇 الفنكشن دي مهمة جداً لتحديث حالة الرسالة
  MessageModel copyWith({DateTime? readAt}) {
    return MessageModel(
      id: id, content: content, messageType: messageType,
      senderId: senderId, receiverId: receiverId, sentAt: sentAt,
      readAt: readAt ?? this.readAt,
      status: status, latitude: latitude, longitude: longitude,
    );
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      content: json['content'],
      messageType: json['messageType'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      sentAt: DateTime.parse(json['sentAt']),
      readAt: json['readAt'] != null ? DateTime.parse(json['readAt']) : null,
      status: json['status'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }
}




// class MessageModel {
//   final String id;
//   final String from;
//   final String to;
//   final String content;
//   final DateTime createdAt;
//   final String type; // "text" أو "location"
//   final double? lat;
//   final double? lng;

//   MessageModel({
//     required this.id,
//     required this.from,
//     required this.to,
//     required this.content,
//     required this.createdAt,
//     this.type = "text",
//     this.lat,
//     this.lng,
//   });

//   // Map<String, dynamic> toJson() {
//   //   return {
//   //     'id': id,
//   //     'from': from,
//   //     'to': to,
//   //     'content': content,
//   //     'createdAt': createdAt,
//   //     'type': type,
//   //     'lat': lat,
//   //     'lng': lng,
//   //   };
//   // }
  
// // factory MessageModel.fromJson(Map<String, dynamic> json) {
// //   final createdAt = json['createdAt'];
// //   return MessageModel(
// //     id: json['id'] ?? "",
// //     from: json['senderEmail'] ?? "",
// //     to: json['reciverEmail'] ?? "",
// //     content: json['text'] ?? "",
// //     createdAt: createdAt is Timestamp ? createdAt.toDate() : DateTime.now(),
// //     type: json['messageType'] ?? "text",
// //     lat: json['lat']?.toDouble(),
// //     lng: json['lng']?.toDouble(),
// //   );
// // }

// }