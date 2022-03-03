import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:efficacy_admin/themes/appcolor.dart';
import 'package:flutter/material.dart';

class Fullscreen extends StatefulWidget {
  File imageFile;
  Fullscreen({Key? key, required this.imageFile}) : super(key: key);

  @override
  State<Fullscreen> createState() => _FullscreenState();
}

class _FullscreenState extends State<Fullscreen> {
  File? imagepicked;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context, imagepicked);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              _getFromGallery();
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context, null);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          height: 300,
          child: Image.file(
            imagepicked == null ? widget.imageFile : imagepicked!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  _getFromGallery() async {
    PickedFile? pickedFile = (await ImagePicker().pickImage(
      source: ImageSource.gallery,
    )) as PickedFile?;
    if (pickedFile != null) {
      setState(() {
        imagepicked = File(pickedFile.path);
      });
    }
  }
}
