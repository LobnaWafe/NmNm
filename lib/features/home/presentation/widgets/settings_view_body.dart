import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_face/constants.dart';
import 'package:simple_face/core/error/failure.dart';
import 'package:simple_face/core/utilis/api/dio_consumer.dart';
import 'package:simple_face/core/utilis/app_router.dart';
import 'package:simple_face/core/utilis/cach_helper.dart';
import 'package:simple_face/features/authentication/data/user_model.dart';
import 'package:simple_face/features/home/presentation/view_models/edit_profile/edit_profile_cubit.dart';
import 'package:simple_face/features/home/presentation/widgets/edit_profile_dialog.dart';
import 'package:simple_face/features/home/presentation/widgets/setting_item.dart';

class SettingsViewBody extends StatefulWidget {
  const SettingsViewBody({super.key});

  @override
  State<SettingsViewBody> createState() => _SettingsViewBodyState();
}

class _SettingsViewBodyState extends State<SettingsViewBody> {
  UserModel? currentUser;

  Future<void> _pickAndUploadImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);
      // نداء الـ Cubit لتحديث الصورة
      context.read<EditProfileCubit>().upDateProfile(
        newName: currentUser!.fullName,
        imageFile: imageFile,
      );
    }
  }

  @override
  void initState() {
    currentUser = CacheHelper.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
       if(state is EditProfileSuccess){
        setState(() {
          currentUser = CacheHelper.getUser();
        });
       } else if(state is EditProfileFailure){
          
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state.errorMsg),
      ),
    );
  
       }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              // مسافة من فوق

              // الصورة الشخصية مع ظل خفيف
               CircleAvatar(
                radius: 52,
                backgroundColor: kPrimaryColorA, // إطار خارجي بلون التطبيق
                child: CircleAvatar(
                  backgroundImage:NetworkImage( currentUser!.profileImageUrl!) ,
              
                  backgroundColor: Colors.white,
                  radius: 50,
                ),
              ),

              const SizedBox(height: 10),

              GestureDetector(
                onTap: _pickAndUploadImage,
                child: Text(
                  "Edit",
                  style: TextStyle(
                    color: kPrimaryColorA,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // كارت بيانات المستخدم
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SettingsItem(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return BlocProvider.value(
                              value: context.read<EditProfileCubit>(),
                              child: EditProfileDialog(userModel: currentUser!),
                            );
                          },
                        );
                      },
                      icon: Icons.person_outline,
                      label: "Name",
                      value: currentUser!.fullName,
                    ),
                    const Divider(height: 30, thickness: 0.5),
                    SettingsItem(
                      icon: Icons.email_outlined,
                      label: "Email",
                      value: currentUser!.email,
                    ),
                  ],
                ),
              ),

              const Spacer(), // بيزق الزرار لتحت خالص
              // زرار تسجيل الخروج
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async{
                    await  CacheHelper.removeUser();
                    await  CacheHelper.removeData(key: "token");
                      GoRouter.of(context).go(AppRouter.kLogin);
                        
                      // هنا هتحطي Logout Logic (مسح التوكن والانتقال للـ Login)
                    },
                    icon: const Icon(Icons.logout, color: Colors.white),
                    label: const Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent, // لون مميز للخروج
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }
}
