import 'package:dartz/dartz.dart';
import 'package:simple_face/core/error/failure.dart';
import 'package:simple_face/features/home/data/models/message_model.dart';
import 'package:simple_face/features/home/data/models/my_chats_model.dart';
import 'package:simple_face/features/home/data/models/users_system_mode.dart';

abstract class HomeRepo {
  Future<Either<Failure,List<MyChatsModel>>>getAllChats({required String endPoint});
  Future<Either<Failure,List<UsersSystemMode>>>getAllUsers({required String endPoint});
 Future<Either<Failure,List<MessageModel>>>getMessagesInChat({required String endPoint});
}