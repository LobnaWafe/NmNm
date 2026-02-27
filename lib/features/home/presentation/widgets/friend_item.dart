import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_face/core/utilis/app_router.dart';
import 'package:simple_face/features/home/data/models/users_system_mode.dart';

class FriendItem extends StatelessWidget {
  const FriendItem({super.key, required this.user});
  final UsersSystemMode user;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: (){
          GoRouter.of(context).push(AppRouter.kRoomView,extra: user);
        },
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage:(user.profileImageUrl != null && user.profileImageUrl!.isNotEmpty) ?
          NetworkImage(
         user.profileImageUrl!
          ) : AssetImage("assets/images/avatar.png"),

          radius: 28,
        )
        ,
        title: Text(user.fullName),
        subtitle: Text(user.email),
      ),
    );
  }
}
