
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:simple_face/core/utilis/cach_helper.dart';
import 'package:simple_face/features/home/data/models/message_model.dart';


class SignalRService {
  HubConnection? hubConnection;
  final String hubUrl = "http://nmnm.runasp.net/chatHub"; 

  // زودنا الـ onReadReceived هنا عشان نبلغ الكيوبيت لما حد يقرأ الرسايل
  void startConnection({
    required Function(MessageModel) onMessageReceived,
    required Function(String) onReadReceived, 
  }) async {
    final token = CacheHelper.getData(key: 'token');

    hubConnection = HubConnectionBuilder()
        .withUrl(
          hubUrl, 
          options: HttpConnectionOptions(
            accessTokenFactory: () async => token ?? "",
          ),
        )
        .withAutomaticReconnect()
        .build();

    try {
      await hubConnection?.start();
      print("✅ SignalR Connected Successfully!");

      hubConnection?.on("ReceiveMessage", (arguments) {
        if (arguments != null && arguments.isNotEmpty) {
          final newMessage = MessageModel.fromJson(arguments[0] as Map<String, dynamic>);
          onMessageReceived(newMessage);
        }
      });
      
      hubConnection?.on("MessagesRead", (arguments) {
        if (arguments != null && arguments.isNotEmpty) {
          print("✅ Someone read your messages: ${arguments[0]}");
          // هنا بنادي الفنكشن اللي بتبلغ الـ UI إن فيه حد قرأ
          onReadReceived(arguments[0].toString());
        }
      });

    } catch (e) {
      print("❌ SignalR Connection Error: $e");
    }
  }

  Future<void> sendMessage(Map<String, dynamic> messageDto) async {
    if (hubConnection?.state == HubConnectionState.Connected) {
      try {
        await hubConnection?.invoke("SendMessage", args: [messageDto]);
      } catch (e) {
        print("❌ Error invoking SendMessage: $e");
      }
    }
  }

Future<void> markAsRead(String senderId) async {
  print("🔥🔥 DEBUG: markAsRead was CALLED for: $senderId"); 

  // 1. لو الاتصال لسه بيفتح، هنستنى شوية ونحاول تاني تلقائياً
  int retryCount = 0;
  while (hubConnection?.state == HubConnectionState.Connecting && retryCount < 10) {
    print("⏳ Connection is busy (Connecting)... waiting 500ms");
    await Future.delayed(const Duration(milliseconds: 500));
    retryCount++;
  }

  // 2. دلوقتي نشيك على الحالة
  if (hubConnection?.state == HubConnectionState.Connected) {
    try {
      await hubConnection?.invoke("MarkAsRead", args: [senderId]);
      print("✅ DEBUG: MarkAsRead INVOKED successfully after connection established");
    } catch (e) {
      print("❌ DEBUG: Error invoking MarkAsRead: $e");
    }
  } else {
    print("⚠️ DEBUG: Cannot markAsRead, Connection state is: ${hubConnection?.state}");
  }
}

  void stopConnection() async {
    if (hubConnection != null) {
      await hubConnection!.stop();
    }
  }
}


