// import 'package:flutter/cupertino.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class ImageUpload {
//   static Future<void> uploadPhoto() async {
//     var status;
//
//     try{
//       print('hhh');
//        status  = await Permission.photos.request().then((value) {
//          print('ttttttt');
//        });
//
//     }catch(e){
//       print('dddd$e');
//     }
//
//     if (status.isGranted) {
//       final imagePicker = ImagePicker();
//       var pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
//
//       if (pickedFile != null) {
//         // User picked an image, do something with it
//         print("Image path: ${pickedFile.path}");
//       } else {
//         // User canceled image selection
//         print("Image selection canceled");
//       }
//     } else {
//       // Permission denied
//       // You can handle the permission denial here or return a value to indicate denial
//     }
//   }
// }


import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';


const allowedFormats = {'image/png', 'image/jpeg', 'video/mp4', 'image/gif'};

class SelectedMedia {
  const SelectedMedia({
    this.storagePath = '',
    this.filePath,
    required this.bytes,
    this.dimensions,
  });
  final String storagePath;
  final String? filePath;
  final Uint8List bytes;
  final MediaDimensions? dimensions;
}

class MediaDimensions {
  const MediaDimensions({
    this.height,
    this.width,
  });
  final double? height;
  final double? width;
}

enum MediaSource {
  photoGallery,
  videoGallery,
  camera,
}

Future<List<SelectedMedia>?> selectMediaWithSourceBottomSheet({

  required BuildContext context,
  String? storageFolderPath,
  double? maxWidth,
  double? maxHeight,
  int? imageQuality,
  required bool allowPhoto,
  bool allowVideo = false,
  bool multiImage = false,
  String pickerFontFamily = 'Roboto',
  Color textColor = const Color(0xFF111417),
  Color backgroundColor = const Color(0xFFF5F5F5),
  bool includeDimensions = false,
}) async {
  final createUploadMediaListTile =
      (String label, MediaSource mediaSource) => ListTile(
    title: Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: textColor,

        fontSize: 20,
      ),

    ),
    tileColor: backgroundColor,
    dense: false,
    onTap: () async {
      if (Platform.isAndroid)  {
        if (mediaSource == MediaSource.camera) {
          var status = await Permission.camera.status;
          if (status.isGranted) {
            Navigator.pop(context, mediaSource);
          } else if (status.isPermanentlyDenied || status.isDenied) {
            final newStatus = await Permission.camera.request();
            if (newStatus == PermissionStatus.denied ||
                newStatus == PermissionStatus.permanentlyDenied) {
              print('DENIED');
              // Dialogs.permissionDenied(context, 'photos or videos', 'Camera');
            } else {
              Navigator.pop(context, mediaSource);
            }
          }
        } else {
          final androidInfo = await DeviceInfoPlugin().androidInfo;
          if (androidInfo.version.sdkInt <= 32) {
            /// use [Permissions.storage.status] for android versions less than or equals 12
            var status = await Permission.storage.status;
            if (status.isGranted) {
              Navigator.pop(context, mediaSource);
            } else if (status.isPermanentlyDenied || status.isDenied) {
              final newStatus = await Permission.storage.request();
              if (newStatus == PermissionStatus.denied ||
                  newStatus == PermissionStatus.permanentlyDenied) {
                print('files denied');
                // Dialogs.permissionDenied(
                //     context, 'photos or videos', 'Files and Media');
              } else {
                Navigator.pop(context, mediaSource);
              }
            }
          } else {
            /// use [Permissions.photos.status] for android versions greater than 12
            var status = await Permission.photos.status;
            if (status.isGranted) {
              Navigator.pop(context, mediaSource);
            } else if (status.isPermanentlyDenied || status.isDenied) {
              final newStatus = await Permission.photos.request();
              if (newStatus == PermissionStatus.denied ||
                  newStatus == PermissionStatus.permanentlyDenied) {
                print('files denied');

              } else {
                Navigator.pop(context, mediaSource);
              }
            }
          }
        }
      }
      // }
    },
    // onTap: () => Navigator.pop(
    //   context,
    //   mediaSource,
    // ),
  );
  final mediaSource = await showModalBottomSheet<MediaSource>(
      context: context,
      backgroundColor: backgroundColor,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!kIsWeb) ...[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: ListTile(
                  title: Text(
                    'Choose Source',

                    textAlign: TextAlign.center,
                    style: TextStyle(

                      color: textColor.withOpacity(0.65),

                    ),
                  ),
                  tileColor: backgroundColor,
                  dense: false,
                ),
              ),
              const Divider(),
            ],
            if (allowPhoto && allowVideo) ...[
              createUploadMediaListTile(
                'Gallery (Photo)',
                MediaSource.photoGallery,
              ),
              const Divider(),
              createUploadMediaListTile(
                'Gallery (Video)',
                MediaSource.videoGallery,
              ),
            ] else if (allowPhoto)
              createUploadMediaListTile(
                'Gallery',
                MediaSource.photoGallery,
              )
            else
              createUploadMediaListTile(
                'Gallery',
                MediaSource.videoGallery,
              ),
            if (!kIsWeb) ...[
              const Divider(),
              createUploadMediaListTile('Camera', MediaSource.camera),
              const Divider(),
            ],
            const SizedBox(height: 10),
          ],
        );
      });
  if (mediaSource == null) {
    return null;
  }
  return selectMedia(
    storageFolderPath: storageFolderPath,
    maxWidth: maxWidth,
    maxHeight: maxHeight,
    imageQuality: imageQuality,
    isVideo: mediaSource == MediaSource.videoGallery ||
        (mediaSource == MediaSource.camera && allowVideo && !allowPhoto),
    mediaSource: mediaSource,
    multiImage: mediaSource == MediaSource.photoGallery,
    includeDimensions: includeDimensions,
  );
}

Future<List<SelectedMedia>?> selectMedia({
  String? storageFolderPath,
  double? maxWidth,
  double? maxHeight,
  int? imageQuality,
  bool isVideo = false,
  MediaSource mediaSource = MediaSource.camera,
  bool multiImage = false,
  bool includeDimensions = false,
}) async {
  final picker = ImagePicker();

  if (multiImage) {
    final pickedMediaFuture = picker.pickMultiImage(
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: imageQuality,
    );
    final pickedMedia = await pickedMediaFuture;
    if (pickedMedia.isEmpty) {
      return null;
    }
    return Future.wait(pickedMedia.asMap().entries.map((e) async {
      final index = e.key;
      final media = e.value;
      final mediaBytes = await media.readAsBytes();
      final path = _getStoragePath(storageFolderPath, media.name, false, index);
      final dimensions =
      includeDimensions ? _getImageDimensions(mediaBytes) : null;
      return SelectedMedia(
        storagePath: path,
        filePath: media.path,
        bytes: mediaBytes,
        dimensions: await dimensions,
      );
    }));
  }

  final source = mediaSource == MediaSource.camera
      ? ImageSource.camera
      : ImageSource.gallery;
  final pickedMediaFuture = isVideo
      ? picker.pickVideo(source: source)
      : picker.pickImage(
    maxWidth: maxWidth,
    maxHeight: maxHeight,
    imageQuality: imageQuality,
    source: source,
  );
  final pickedMedia = await pickedMediaFuture;
  final mediaBytes = await pickedMedia?.readAsBytes();
  if (mediaBytes == null) {
    return null;
  }
  final path = _getStoragePath(storageFolderPath, pickedMedia!.name, isVideo);
  final dimensions = includeDimensions ? _getImageDimensions(mediaBytes) : null;
  return [
    SelectedMedia(
      storagePath: path,
      filePath: pickedMedia.path,
      bytes: mediaBytes,
      dimensions: await dimensions,
    ),
  ];
}
//
// bool validateFileFormat(String filePath, BuildContext context) {
//
//   ScaffoldMessenger.of(context)
//     ..hideCurrentSnackBar()
//     ..showSnackBar(SnackBar(
//
//     ));
//   return false;
// }

Future<SelectedMedia?> selectFile({
  String? storageFolderPath,
  List<String>? allowedExtensions,
}) async {
  final pickedFiles = await FilePicker.platform.pickFiles(
    type: allowedExtensions != null ? FileType.custom : FileType.any,
    allowedExtensions: allowedExtensions,
    withData: true,
  );
  if (pickedFiles == null || pickedFiles.files.isEmpty) {
    return null;
  }

  final file = pickedFiles.files.first;
  if (file.bytes == null) {
    return null;
  }
  final storagePath = _getStoragePath(storageFolderPath, file.name, false);
  return SelectedMedia(
    storagePath: storagePath,
    filePath: file.path,
    bytes: file.bytes!,
  );
}

Future<MediaDimensions> _getImageDimensions(Uint8List mediaBytes) async {
  final image = await decodeImageFromList(mediaBytes);
  return MediaDimensions(
    width: image.width.toDouble(),
    height: image.height.toDouble(),
  );
}

// Future<MediaDimensions> _getVideoDimensions(String path) async {
//   final VideoPlayerController videoPlayerController =
//       VideoPlayerController.asset(path);
//   await videoPlayerController.initialize();
//   final size = videoPlayerController.value.size;
//   return MediaDimensions(width: size.width, height: size.height);
// }

String _getStoragePath(
    String? pathPrefix,
    String filePath,
    bool isVideo, [
      int? index,
    ]) {
  // pathPrefix ??= _firebasePathPrefix();
  pathPrefix = _removeTrailingSlash(pathPrefix);
  final timestamp = DateTime.now().microsecondsSinceEpoch;
  // Workaround fixed by https://github.com/flutter/plugins/pull/3685
  // (not yet in stable).
  final ext = isVideo ? 'mp4' : filePath.split('.').last;
  final indexStr = index != null ? '_$index' : '';
  return '$pathPrefix/$timestamp$indexStr.$ext';
}

String getSignatureStoragePath([String? pathPrefix]) {
  // pathPrefix ??= _firebasePathPrefix();
  pathPrefix = _removeTrailingSlash(pathPrefix);
  final timestamp = DateTime.now().microsecondsSinceEpoch;
  return '$pathPrefix/signature_$timestamp.png';
}

void showUploadMessage(BuildContext context, String message,
    {bool showLoading = false}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Row(
              children: [
                if (showLoading)
                  SizedBox(
                      height: 24.r,
                      width: 24.r,
                      child: CircularProgressIndicator(color: Colors.green)),
                if (showLoading == false)
                  Image.asset(
                    'assets/images/done_snackbar.png',
                    height: 24.r,
                    width: 24.r,
                  ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.w, 0, 16.w, 0),
                  child: Text(
                    message,

                    style: TextStyle(
                      color: Color(0xff23272A),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'segoe ui',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color(0xffF1F4F8),
        duration: Duration(seconds: showLoading ? 20 : 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
          side: BorderSide(
            color: Color(0xFF499942),
            width: 1.0.w,
          ),
        ),
      ),
    );
}

String? _removeTrailingSlash(String? path) => path != null && path.endsWith('/')
    ? path.substring(0, path.length - 1)
    : path;

// String _firebasePathPrefix() => 'users/$currentUserUid/uploads';

