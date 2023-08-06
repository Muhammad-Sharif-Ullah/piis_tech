import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:piis_tech/core/theme/app_colors.dart';

final _picker = ImagePicker();

takeFromGallery(BuildContext context, Map<String, dynamic> imageDataMap
    // String rename
    ) async {
  return await _picker
      .pickImage(
    source: ImageSource.gallery,
  )
      .then((xPath) {
    if (xPath != null) {
      //   log("Image Taken Done ${xPath.path} ");
      // File convertFile = File(xPath.path);
      // String dir = path.dirname(convertFile.path);
      // String extension = path.extension(convertFile.path);

      // String newName = path.join(dir, '$rename$extension');
      // convertFile.renameSync(newName);
      File image = File(xPath.path);
      print(getFileSizeString(bytes: image.lengthSync()));
      final Map<String, dynamic> fileSize =
          getFileSizeString(bytes: image.lengthSync());
      imageDataMap = {
        "rename": xPath.path,
        "fileSize": fileSize['fileSize'],
        "sizeName": fileSize['sizeName'],
        "indexFile": fileSize['indexFile']
      };
      return Navigator.pop(context, imageDataMap);
    } else {
      // log("Image Not Taken ");
      return Navigator.pop(context, null);
    }
  });
}

takeFromCamera(BuildContext context, Map<String, dynamic> imageDataMap) async {
  // ignore: unused_local_variable
  // final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
  return await _picker
      .pickImage(
    source: ImageSource.camera,
    // imageQuality: 50,
    // maxHeight: 600,
    // maxWidth: 900
  )
      .then((xPath) async {
    if (xPath != null) {
      // log("Image Taken Done ${xPath.path} ");
      // File convertFile = File(xPath.path);
      // String dir = path.dirname(convertFile.path);
      // String extension = path.extension(convertFile.path);

      // String newName = path.join(dir, '$rename$extension');
      // convertFile.renameSync(newName);
      // ##### Convert image Size .
      final decodedImage = await decodeImageFromList(await xPath.readAsBytes());
      print(
          '-------------------------------Hight : ${decodedImage.height}___________');
      print(
          '-------------------------------Hight : ${decodedImage.width}___________');
      if (decodedImage.height > 255 && decodedImage.width > 255) {
        //do your validation here
      }
      File image = File(xPath.path);
      print(getFileSizeString(bytes: image.lengthSync()));
      print(image.lengthSync());
      final Map<String, dynamic> fileSize =
          getFileSizeString(bytes: image.lengthSync());
      imageDataMap = {
        "rename": xPath.path,
        "fileSize": fileSize['fileSize'],
        "sizeName": fileSize['sizeName'],
        "indexFile": fileSize['indexFile']
      };
      // ignore: use_build_context_synchronously
      return Navigator.pop(context, imageDataMap);
    } else {
      print("Image Not Taken ");
      return Navigator.pop(context, null);
    }
  });
}

// Output: 17kb, 30mb, 7gb

// Format File Size
Map<String, dynamic> getFileSizeString({required int bytes, int decimals = 0}) {
  const suffixes = ["b", "kb", "mb", "gb", "tb"];
  var i = (log(bytes) / log(1024)).floor();

  return {
    "fileSize": ((bytes / pow(1024, i)).toStringAsFixed(decimals)),
    "sizeName": suffixes[i],
    "indexFile": i,
  };
}

Container captureButton(
    {required onTap, bool isCamera = false, required BuildContext context}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: Theme.of(context).primaryColor)),
    child: RawMaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Icon(
          isCamera ? CupertinoIcons.camera_viewfinder : CupertinoIcons.photo,
          color: Colors.white,
          size: 50,
        ),
      ),
    ),
  );
}

Future<Map<String, dynamic>?> imageModal(
  BuildContext context,
  final String title,
  String message,
  String fileLimit,
  final bool isDarkMode,
  // final String rename,
  // final String fileSize,
  Map<String, dynamic> imageDataMap,
) async {
  return await showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(title),
        message: Column(
          children: [
            Text(message),
            5.verticalSpace,
            Text(
              "Maximum file size limit [$fileLimit]",
              style: const TextStyle(color: Colors.redAccent),
            ),
            5.verticalSpace,
          ],
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text(
              "Take Photo By Camera",
              style: TextStyle(
                fontSize: 12,
                fontFamily: "Poppins",
                color: isDarkMode ? null : AppColors.magenta,
              ),
            ),
            onPressed: () async {
              await takeFromCamera(context, imageDataMap);
            },
          ),
          CupertinoActionSheetAction(
              child: Text(
                'Take Photo from Gallery',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Poppins",
                  color: isDarkMode ? null : AppColors.magenta,
                ),
              ),
              onPressed: () async {
                await takeFromGallery(context, imageDataMap);
              }),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              fontSize: 15,
              fontFamily: "Poppins",
              color: isDarkMode ? Colors.white70 : AppColors.primaryColor,
            ),
          ),
        )),
  );
}
