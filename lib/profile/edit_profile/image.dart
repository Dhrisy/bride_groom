import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePick extends StatefulWidget {
  const ImagePick({Key? key}) : super(key: key);

  @override
  State<ImagePick> createState() => _ImagePickState();
}

class _ImagePickState extends State<ImagePick> {

  List<XFile>? _mediaFileList;

  void _setImageFileListFromFile(XFile? value) {
    _mediaFileList = value == null ? null : <XFile>[value];
    print('>>>>>>>>>${_mediaFileList}');
  }

  XFile? image;

  final ImagePicker _picker = ImagePicker();


  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: media,
        maxWidth: 100,
        maxHeight: 100,
        // imageQuality: quality,
      );
      setState(() {
        image = pickedFile;
        // _setImageFileListFromFile(pickedFile);
        print(',,,,,,,,,,,,,}');
      });
    } catch (e) {print('kkjljkjhjhvghgafdhgfhfhafh');
      setState(() {
      });
    }
  }


  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
      return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    title: Text('Please choose media to select'),
    content: Container(
    height: MediaQuery.of(context).size.height / 6,
    child: Column(
    children: [
    ElevatedButton(
    //if user click this button, user can upload image from gallery
    onPressed: () {
    Navigator.pop(context);
    getImage(ImageSource.gallery);
    },
      child: Row(
        children: [
          Icon(Icons.image),
          Text('From Gallery'),
        ],
      ),
    ),
          ElevatedButton(
          //if user click this button. user can upload image from camera
          onPressed: () {
        Navigator.pop(context);
        getImage(ImageSource.camera);
      },
    child: Row(
    children: [
    Icon(Icons.camera),
    Text('From Camera'),
    ],
    ),
          ),
    ],
    ),
    ),
      );
        });
  }



  @override
  Widget build(BuildContext context) {
    if(image == null){
      print('yyyyyyyyyyyyyyyyyyy');
    }else{
      print('bbbb${image!.path}');
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                myAlert();
              },
              child: Text('Upload Photo'),
            ),
            SizedBox(
              height: 10,
            ),
            //if image not null show the image
            //if image null show text
            image != null
                ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  //to show image, you type like this.
                  File(image!.path),
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                ),
              ),
            )
                : Text(
              "No Image",
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
