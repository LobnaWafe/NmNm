import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_face/constants.dart';
import 'package:simple_face/features/authentication/data/user_model.dart';
import 'package:simple_face/features/home/presentation/view_models/edit_profile/edit_profile_cubit.dart';

class EditProfileDialog extends StatefulWidget {
  const EditProfileDialog({super.key,required this.userModel});
  
  final UserModel userModel;
  @override
  State<EditProfileDialog> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileDialog> {
  late TextEditingController controller; // خليناه late عشان نعرفه في الـ initState

  @override
  void initState() {
    super.initState();
    // 👇 هنا بنحط القيمة اللي جاية من بره جوه الكنترولر أول ما الـ Dialog يفتح
    controller = TextEditingController(text: widget.userModel.fullName);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 174, 171, 171),
      
      title: Text("Edit Name", 
        style: const TextStyle(color: Colors.white, fontSize: 18)),
      content: TextField(
        controller: controller,
        cursorColor: Colors.white70,
        style: const TextStyle(color: Colors.white), // لون الكتابة
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.white24),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: kPrimaryColorA, width: 2),
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween, // 👇 بيوزع الأزرار بالعرض
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel", style: TextStyle(color: Colors.white70)),
        ),


        ElevatedButton(
          onPressed: () {
            // هنا هترجعي القيمة الجديدة بالـ Navigator.pop
              context.read<EditProfileCubit>().upDateProfile(
        newName:controller.text,
     
      );
            Navigator.pop(context, controller.text);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColorA,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text("Save", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}