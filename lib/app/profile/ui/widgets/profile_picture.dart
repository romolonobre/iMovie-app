import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imovie_ui/imovie_ui.dart';

import '../../../_commons/user/entities/app_user.dart';
import '../../../authentication/interactor/login_controller.dart';
import 'image_picker_option.dart';

class ProfilePicture extends StatefulWidget {
  final LoginController controller;
  const ProfilePicture(this.controller, {super.key});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  late AppUser? user;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    user = widget.controller.getUser();

    return GestureDetector(
      onTap: () async {
        final success = await openImagePicker();
        if (success) setState(() {});
      },
      child: CircleAvatar(
        radius: 70,
        backgroundImage: user!.imageUrl.isNotEmpty ? FileImage(File(user!.imageUrl)) : null,
        child: user!.imageUrl.isEmpty ? placeHolder() : null,
      ),
    );
  }

  Widget placeHolder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.add,
          color: IUIPalette.primaryColor,
          size: 30,
        ),
        IUIText.heading(
          'Add profile picture',
          color: IUIPalette.primaryColor,
          fontsize: 12,
        )
      ],
    );
  }

  Future<bool> openImagePicker() async {
    final result = await IUIBottomSheet.show(
      context,
      content: SizedBox(
        height: 300,
        width: double.infinity,
        child: Column(
          children: [
            IUIText.heading(
              "Upload profile picture",
              color: IUIPalette.primaryColor,
              fontWeight: FontWeight.w500,
              fontsize: 18,
            ),
            IUIText.heading(
              "Select from where you want to upload",
              color: Colors.black54,
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Camera picker
                ImagePickerOption(
                  label: "Camera",
                  icon: Icons.add_a_photo,
                  source: ImageSource.camera,
                  onImageSelected: (image) async {
                    await widget.controller.updateProfileImage(image);
                    Modular.to.pop(true);
                  },
                ),
                const SizedBox(width: 15),

                // Gallery picker
                ImagePickerOption(
                  label: "Gallery",
                  icon: Icons.add_photo_alternate_sharp,
                  source: ImageSource.gallery,
                  onImageSelected: (image) async {
                    await widget.controller.updateProfileImage(image);
                    Modular.to.pop(true);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
    return result == true;
  }
}
