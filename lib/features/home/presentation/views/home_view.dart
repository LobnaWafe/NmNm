import 'package:flutter/material.dart';
import 'package:simple_face/constants.dart';
import 'package:simple_face/core/services/noti/push_notification_services.dart';
import 'package:simple_face/features/home/presentation/views/chats_view.dart';
import 'package:simple_face/features/home/presentation/views/friends_view.dart';
import 'package:simple_face/features/home/presentation/views/settings_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Widget> widgets = [ChatsView(), FriendsView(), SettingsView()];
  var index = 0;
 
  @override
  void initState() {
    // TODO: implement initState
    PushNotificationServices.init(); // <<--
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorB,
      body: widgets[index],
      bottomNavigationBar: SafeArea(
        child: BottomNavigationBar(
          backgroundColor: kPrimaryColorB,
          selectedItemColor: kPrimaryColorA,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_add_sharp),
              label: "Friends",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          currentIndex: index,
        ),
      ),
    );
  }
}
