import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:simple_face/features/home/data/models/message_model.dart';

class ReceiveMessageContainer extends StatelessWidget {
  const ReceiveMessageContainer({super.key, required this.messageModel});
  final MessageModel messageModel;

@override
Widget build(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start, // او end حسب المرسل
    children: [
      Flexible(
  
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * 0.6,
          ),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 85, 91, 93),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${messageModel.content}    " ,
                style: const TextStyle(color: Colors.white,
                fontSize: 18
                ),
              ),
           //   const SizedBox(height: 4),
              Text(
                formattedTime(messageModel.sentAt),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

  String formattedTime(dynamic createdAt) {
    return intl.DateFormat('h:mm a').format(createdAt);
  }
}
