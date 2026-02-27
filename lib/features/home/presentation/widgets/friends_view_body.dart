import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_face/constants.dart';
import 'package:simple_face/features/home/presentation/view_models/get_all_users/get_all_users_cubit.dart';
import 'package:simple_face/features/home/presentation/widgets/friend_item.dart';

class FriendsViewBody extends StatelessWidget {
  const FriendsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetAllUsersCubit, GetAllUsersState>(
      listener: (context, state) {
        if(state is GetAllUsersFailure){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMsg))
          );
        }
      },
      builder: (context, state) {
        return state is GetAllUsersSuccess? ListView.builder(
          itemCount:state.users.length ,
          itemBuilder: (context, index) {
            return FriendItem(
              user: state.users[index]
            );
          },
        ): state is GetAllUsersLoading?Center(child: CircularProgressIndicator(color: kPrimaryColorA,),): Center(
          child: Text("Oops! it's error , please try again"),
        );
      },
    );
  }
}
