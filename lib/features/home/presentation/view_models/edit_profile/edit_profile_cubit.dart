import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:simple_face/core/error/failure.dart';
import 'package:simple_face/core/utilis/api/dio_consumer.dart';
import 'package:simple_face/core/utilis/cach_helper.dart';
import 'package:simple_face/features/authentication/data/user_model.dart';

part 'edit_profile_state.dart';
class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(this.api) : super(EditProfileInitial());
  final DioConsumer api;

  Future<void> upDateProfile({
    String? newName,
    File? imageFile, // بنبعت الملف هنا
  }) async {
    emit(EditProfileLoading());
    try {
      // تجهيز البيانات
      Map<String, dynamic> data = {};
      if (newName != null) data["Name"] = newName;
      if (imageFile != null) {
        data["ProfileImage"] = await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        );
      }

      var formData = FormData.fromMap(data);

      var response = await api.put(
        "api/User/UpdateUser",
        data: formData,
      );

      // تحويل الرد لموديل وحفظه
      UserModel updatedUser = UserModel.fromJson(response);
      
      // 🔥 حفظ في الكاش فوراً
      await CacheHelper.saveUser(updatedUser);

      emit(EditProfileSuccess(userModel: updatedUser));
    } on Failure catch (e) {
      emit(EditProfileFailure(errorMsg: e.errorMsg));
    } catch (e) {
      emit(EditProfileFailure(errorMsg: e.toString()));
    }
  }
}