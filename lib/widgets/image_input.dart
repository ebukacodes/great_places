import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as systemPaths;

class ImageInput extends StatefulWidget {
  final Function _onSelectImage;

  ImageInput(this._onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  // Open Camera
  Future<void> _takePicture() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = imageFile;
    });
    // Save image to phone storage
    final appDir = await systemPaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    widget._onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(_storedImage,
                  fit: BoxFit.cover, width: double.infinity)
              : Text('No image selected'),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: RaisedButton.icon(
          onPressed: _takePicture,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
          icon: Icon(Icons.camera),
          label: Text(
            'Take a picture',
            textAlign: TextAlign.center,
          ),
          textColor: Theme.of(context).primaryColor,
        )),
      ],
    );
  }
}

// Container(
//              height: 50.0,
//              margin: EdgeInsets.all(10),
//              child: RaisedButton(
//                onPressed: () {},
//                shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(80.0)),
//                padding: EdgeInsets.all(0.0),
//                child: Ink(
//                  decoration: BoxDecoration(
//                      gradient: LinearGradient(
//                        colors: [Color(0xff374ABE), Color(0xff64B6FF)],
//                        begin: Alignment.centerLeft,
//                        end: Alignment.centerRight,
//                      ),
//                      borderRadius: BorderRadius.circular(30.0)),
//                  child: Container(
//                    constraints:
//                        BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
//                    alignment: Alignment.center,
//                    child: Text(
//                      "Gradient Button",
//                      textAlign: TextAlign.center,
//                      style: TextStyle(color: Colors.white, fontSize: 15),
//                    ),
//                  ),
//                ),
//              ),
//            ),
