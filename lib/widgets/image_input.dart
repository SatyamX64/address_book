import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  final Function setImage;
  ImageInput(this.setImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _selectedImage;
  final imagePicker = ImagePicker();

  Future _takeImage() async {
    // Use maxWidth to make sure higher resolution images don't load up unnecessarily
    // will save us some performance
    final pickedFile =
        await imagePicker.getImage(source: ImageSource.camera, maxWidth: 600);
    if (pickedFile == null) return;
    setState(() {
      _selectedImage = File(pickedFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(pickedFile.path);
    final savedImage = await _selectedImage.copy('${appDir.path}/$filename');
    widget.setImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          height: 100,
          width: 150,
          child: _selectedImage != null
              ? Image.file(
                  _selectedImage,
                  fit: BoxFit.cover,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        Expanded(
          child: TextButton.icon(
              onPressed: _takeImage,
              icon: Icon(Icons.camera),
              label: Text(
                'Take Image',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              )),
        )
      ],
    );
  }
}
