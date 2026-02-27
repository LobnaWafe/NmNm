import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:simple_face/constants.dart';
import 'package:simple_face/features/home/data/models/message_model.dart';

class SendMessageContainer extends StatelessWidget {
  const SendMessageContainer({super.key, required this.messageModel});
  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    // تحديد لون وحالة علامة الصح بناءً على readAt أو status
    // لو readAt مش null يبقى الرسالة اتقرأت
    bool isRead = messageModel.readAt != null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width * 0.7, // كبرت المساحة شوية
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: kPrimaryColorA,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  messageModel.content,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      formattedTime(messageModel.sentAt),
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(width: 4),
                    // أيقونة علامات الصح
                    Icon(
                      isRead ? Icons.done_all : Icons.done, // صح واحدة أو اتنين
                      size: 16,
                      color: isRead ? Colors.blueAccent : Colors.white.withOpacity(0.7),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String formattedTime(DateTime createdAt) {
    return intl.DateFormat('h:mm a').format(createdAt);
  }
}