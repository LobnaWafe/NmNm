import 'package:dartz/dartz.dart';
import 'package:simple_face/core/error/failure.dart';
import 'package:simple_face/core/utilis/api/dio_consumer.dart';
import 'package:simple_face/features/home/data/models/message_model.dart';
import 'package:simple_face/features/home/data/models/my_chats_model.dart';
import 'package:simple_face/features/home/data/models/users_system_mode.dart';
import 'package:simple_face/features/home/repos/home_repo.dart';

class HomeRepoImp implements HomeRepo {
  final DioConsumer api;

  HomeRepoImp({required this.api});
  @override
  Future<Either<Failure, List<MyChatsModel>>> getAllChats({required String endPoint}) async{
        try {
      var response = await api.get(endPoint);
      List data = response as List; // 👈 مهم

      List<MyChatsModel> myUsers = data
          .map((e) => MyChatsModel.fromJson(e))
          .toList();
          print("////");
      print(myUsers);
          
      return right(myUsers);
    } on Failure catch (failure) {
      return left(failure);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UsersSystemMode>>> getAllUsers({
    required String endPoint,
  }) async {
    try {
      var response = await api.get(endPoint);
      List data = response as List; // 👈 مهم

      List<UsersSystemMode> users = data
          .map((e) => UsersSystemMode.fromJson(e))
          .toList();
          print("////");
      print(users);
          
      return right(users);
    } on Failure catch (failure) {
      return left(failure);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<MessageModel>>> getMessagesInChat({required String endPoint}) async{
      try {
      var response = await api.get(endPoint);
      List data = response as List; // 👈 مهم

      List<MessageModel> messages = data
          .map((e) => MessageModel.fromJson(e))
          .toList();
          print("////");
      print(messages);
          
      return right(messages);
    } on Failure catch (failure) {
      return left(failure);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
