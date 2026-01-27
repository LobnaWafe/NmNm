import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatefulWidget {
  const PickImage({super.key, required this.onImagePicked});

  final Function(File profileImage)onImagePicked;
  
  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  File? imageFile;
  final ImagePicker imagePicker = ImagePicker();

  Future<void> pickImage() async{
 final XFile?pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

 if(pickedImage != null){
  final file = File(pickedImage.path);
  setState(() {
    imageFile = File(pickedImage.path);

  });
  log(file.path);
  widget.onImagePicked(file);

 }

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
      pickImage();
      },
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: imageFile !=null?FileImage(imageFile!):
         AssetImage("assets/images/avatar.png") as ImageProvider,
        radius: 45,
      ),
    );
  }
}