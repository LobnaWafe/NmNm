import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_face/core/services/noti/local_notification_services.dart';
import 'package:simple_face/core/utilis/signl_r_services.dart';
import 'package:simple_face/features/home/data/models/users_system_mode.dart';
import 'package:simple_face/features/home/presentation/view_models/get_messages_in_chat/get_messages_in_chat_cubit.dart';
import 'package:simple_face/features/home/presentation/widgets/chat_text_feild.dart';
import 'package:simple_face/features/home/presentation/widgets/receive_message_container.dart';
import 'package:simple_face/features/home/presentation/widgets/send_message_container.dart';

class RoomViewBody extends StatefulWidget {
  const RoomViewBody({super.key, required this.user});
  final UsersSystemMode user;

  @override
  State<RoomViewBody> createState() => _RoomViewBodyState();
}

class _RoomViewBodyState extends State<RoomViewBody> {
  final SignalRService _signalRService = SignalRService();

  @override
  void initState() {
    super.initState();

    // 1. جلب الرسائل القديمة
    // 1. جلب الرسائل القديمة من الـ API
    context
        .read<GetMessagesInChatCubit>()
        .getMessagesMethod(endPoint: "api/Chat/conversation/${widget.user.id}")
        .then((_) {
          // 👈 الإضافة هنا: أول ما الرسايل توصل، لونها أزرق عندي فوراً لأن الشات مفتوح
          // if (mounted) {
          //   context.read<GetMessagesInChatCubit>().updateMessagesStatusToRead(widget.user.id);
          // }
        });
    // 2. تشغيل السوكيت

    _signalRService.startConnection(
      onMessageReceived: (newMessage) {
        if (mounted) {
          if (newMessage.senderId == widget.user.id) {
            // 1. أضف الرسالة للشات مباشرة
            context.read<GetMessagesInChatCubit>().addNewMessage(newMessage);

            // 2. أبلغ السيرفر بالقراءة
            _signalRService.markAsRead(widget.user.id);
          } else {
            // 🔔 الرسالة من شخص آخر -> حولها لـ RemoteMessage وأظهر نوتفيكيشن
            RemoteMessage remoteMessage = RemoteMessage(
              notification: RemoteNotification(
                title: "رسالة جديدة",
                body: newMessage.content, // محتوى الرسالة يظهر هنا
              ),
              data: {"senderId": newMessage.senderId.toString()},
            );

            LocalNotificationService.showBasicNotification(remoteMessage);
          }

          // // 1. ضيفي الرسالة للشاشة
          // context.read<GetMessagesInChatCubit>().addNewMessage(newMessage);

          // // 2. بلغي السيرفر فوراً إنك قريتي الرسالة دي (عشان تلون أزرق عند الطرف التاني)
          // _signalRService.markAsRead(widget.user.id);
        }
      },

      onReadReceived: (readerId) {
        if (mounted) {
          // 3. لما الطرف التاني يقرأ، السيرفر هيبعت الإشارة دي، فتلوني رسايلك إنتي أزرق
          context.read<GetMessagesInChatCubit>().updateMessagesStatusToRead(
            readerId,
          );
        }
      },
    );

    // 3. تأكدي من استدعاء markAsRead بعد التأكد من وجود الـ context والاتصال
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _signalRService.markAsRead(widget.user.id);
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        _signalRService.markAsRead(widget.user.id);
      }
    });
  }

  @override
  void dispose() {
    _signalRService.stopConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Expanded(child: ChatsContentListView(receiverId: widget.user.id)),
        const SizedBox(height: 10),
        ChatTextFeild(
          receiverId: widget.user.id,
          signalRService: _signalRService,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class ChatsContentListView extends StatelessWidget {
  const ChatsContentListView({super.key, required this.receiverId});
  final String receiverId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMessagesInChatCubit, GetMessagesInChatState>(
      builder: (context, state) {
        if (state is GetMessagesInChatSuccess) {
          // بنعكس القائمة عشان مع reverse: true تظهر الرسائل الجديدة تحت
          final messages = state.messages.reversed.toList();

          if (messages.isEmpty) {
            return const Center(child: Text("ابدأ المحادثة الآن"));
          }

          return ListView.builder(
            // 👇 الخاصية دي بتخلي السكرول يبدأ من تحت
            reverse: true,
            itemCount: messages.length,
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            itemBuilder: (context, index) {
              final message = messages[index];

              // 👇 إضافة أنيميشن بسيط لكل رسالة تظهر
              return TweenAnimationBuilder(
                duration: const Duration(milliseconds: 300),
                tween: Tween<double>(begin: 0, end: 1),
                builder: (context, double value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: message.senderId == receiverId
                      ? ReceiveMessageContainer(messageModel: message)
                      : SendMessageContainer(messageModel: message),
                ),
              );
            },
          );
        } else if (state is GetMessagesInChatFailure) {
          return Center(child: Text(state.errorMsg));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
