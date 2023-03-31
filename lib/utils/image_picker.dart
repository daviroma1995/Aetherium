import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'constants.dart';
import 'permission_utils.dart';

enum ActionStyle { normal, destructive, important, important_destructive }

class CustomDialog extends StatelessWidget {
  final String? title, description, buttonText;
  final Image? image;
  final Function? function;

  const CustomDialog(
      {this.title,
      this.description,
      this.buttonText,
      this.image,
      this.function});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            padding: const EdgeInsets.only(
                top: 100, bottom: 16, left: 16, right: 16),
            margin: const EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(17),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  )
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title ?? "",
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 24.0),
                Text(description ?? "", style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 24.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: MaterialButton(
                    onPressed: () {
                      if (function != null) {
                        function!.call();
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Text(buttonText ?? ""),
                  ),
                )
              ],
            )),
        Positioned(
            top: 0,
            left: 16,
            right: 16,
            child: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              radius: 50,
              child: ClipOval(
                child: image,
              ),
            ))
      ],
    );
  }
}

class CameraGalleryBottomSheet extends StatelessWidget {
  Function? cameraClick;
  Function? galleryClick;
  Function(File? file)? onFileSelected;

  CameraGalleryBottomSheet({this.cameraClick, this.galleryClick});

  File? file;
  final picker = ImagePicker();

  Future getImage(ImageSource imageSource, BuildContext context) async {
    final pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      file = File(pickedFile.path);
      // onFileSelected.call(file);
      ImageProperties properties =
          await FlutterNativeImage.getImageProperties(file!.path);
      File compressedFile = await FlutterNativeImage.compressImage(file!.path,
          quality: 100,
          targetWidth: 900,
          targetHeight: (properties.height! * 900 / properties.width!).round());

      Navigator.pop(context, compressedFile);
    } else {
      print('No image selected.');
      onFileSelected?.call(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 30),
      height: 250,
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: () {
              //cameraClick.call();
              getImage(ImageSource.camera, context);
            },
            leading: const Icon(Icons.camera,
                size: 30, color: AppColors.PRIMARY_COLOR),
            title: const Text(
              'Camera',
              style: TextStyle(fontSize: 20, color: AppColors.PRIMARY_COLOR),
            ),
            subtitle: const Text(
              'Pick Image from Camera',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ListTile(
            onTap: () {
              // galleryClick.call();
              getImage(ImageSource.gallery, context);
              // Navigator.pop(context);
            },
            leading: const Icon(
              Icons.browse_gallery,
              size: 30,
              color: AppColors.PRIMARY_COLOR,
            ),
            title: const Text(
              'Gallery',
              style: TextStyle(fontSize: 20, color: AppColors.PRIMARY_COLOR),
            ),
            subtitle: const Text(
              'Pick Image from gallery',
              style: TextStyle(color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}

Future<File?> kImagePicker(BuildContext context,
    {String title = ' AppLanguages.CHOOSE_VALUE', String message = ""}) async {
  if (!await PermissionUtils(
          permission: Permission.camera,
          permissionName: "Camera",
          context: Get.context!)
      .isAllowed) {
    print("camera");
    return null;
  }
  // if (!await PermissionUtils(
  //         permission: Permission.photos,
  //         permissionName: "Photos",
  //         context: Get.context!)
  //     .isAllowed) {
  //   print("photos");
  //   return null;
  // }

  if (Platform.isAndroid) {
    return await showModalBottomSheet(
        context: context, builder: (context) => CameraGalleryBottomSheet());
  }
  print("openinig");
  var input =
      await showModalActionSheet(context: context, title: title, actions: [
    const SheetAction(label: 'AppLanguages.TAKE_PHOTO', key: "0"),
    const SheetAction(label: 'AppLanguages.CHOOSE_FROM_LIBRARY', key: "1")
  ]);
  if (input?.isEmpty ?? true) return null;
  return _getImage(
      input == "0" ? ImageSource.camera : ImageSource.gallery, context);
}

Future<File?> _getImage(ImageSource imageSource, BuildContext context) async {
  File file;
  final picker = ImagePicker();

  final pickedFile = await picker.pickImage(source: imageSource);

  if (pickedFile != null) {
    file = File(pickedFile.path);
    ImageProperties properties =
        await FlutterNativeImage.getImageProperties(file.path);
    File compressedFile = await FlutterNativeImage.compressImage(file.path,
        quality: 40,
        targetWidth: 900,
        targetHeight: (properties.height! * 900 / properties.width!).round());
    print("***************************************");
    print(compressedFile);
    print("***************************************");

    return compressedFile;
  } else {
    print('No image selected.');
    return null;
  }
}
