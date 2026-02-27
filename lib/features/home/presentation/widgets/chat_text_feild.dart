import 'package:flutter/material.dart';
import 'package:simple_face/constants.dart';
import 'package:simple_face/core/utilis/signl_r_services.dart'; // تأكدي من المسار

class ChatTextFeild extends StatefulWidget {
  const ChatTextFeild({
    super.key, 
    required this.receiverId, 
    required this.signalRService,
  });

  final String receiverId;
  final SignalRService signalRService;

  @override
  State<ChatTextFeild> createState() => _ChatTextFeildState();
}

class _ChatTextFeildState extends State<ChatTextFeild> {
  late TextEditingController messageController;

  @override
  void initState() {
    messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  // فنكشن الإرسال بناءً على الـ DTO اللي طالبه الباك أند
  void sendMessage() {
    final String content = messageController.text.trim();
    
    if (content.isNotEmpty) {
      // تجهيز الداتا حسب كود الباك (SendMessageRequestDTo)
      final Map<String, dynamic> messageDto = {
        "receiverId": widget.receiverId,
        "content": content,
        "messageType": 0, // 0 للنص
        "latitude": 0,
        "longitude": 0
      };

      // نداء الـ invoke من خلال السيرفس
      widget.signalRService.sendMessage(messageDto);
      
      // مسح التكست فيلد بعد الإرسال
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 5),
              child: TextField(
                minLines: 1,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                cursorColor: Colors.black,
                controller: messageController,
                decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 212, 221, 235),
                  filled: true,
                  contentPadding: const EdgeInsets.only(left: 15),
                  hintText: "Send Message",
                  border: buildBorder(),
                  enabledBorder: buildBorder(),
                  focusedBorder: buildBorder(),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: sendMessage, // استدعاء فنكشن الإرسال
              child: CircleAvatar(
                backgroundColor: kPrimaryColorA,
                radius: 25,
                child: const Icon(
                  Icons.send_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(20),
    );
  }
}