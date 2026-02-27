import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_face/constants.dart';
import 'package:simple_face/core/utilis/api/dio_consumer.dart';
import 'package:simple_face/features/home/presentation/view_models/edit_profile/edit_profile_cubit.dart';
import 'package:simple_face/features/home/presentation/widgets/settings_view_body.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(DioConsumer(dio: Dio())),
      child: Scaffold(
        backgroundColor: kPrimaryColorB,
        body: SafeArea(child: SettingsViewBody()),
      ),
    );
  }
}
