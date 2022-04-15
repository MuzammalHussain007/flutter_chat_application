import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as pick;
import 'package:image_picker/image_picker.dart';


class ImagePicker extends StatefulWidget {
  ImagePicker(this._pickedImage);
 final void Function(File? pickedImage ) _pickedImage ;
  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  File? _pickedImages ;

  void _selectImage() async {
    final pickedImagefile = await pick.ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {

      _pickedImages =File(pickedImagefile!.path);
      widget._pickedImage(_pickedImages);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          CircleAvatar(radius: 40,
            backgroundImage: _pickedImages !=null ? FileImage(_pickedImages!) : null,
        ),
        FlatButton.icon(onPressed: (){
          _selectImage();
        },
          icon: const Icon(Icons.image,color: Colors.pink,),
          label: const Text('Select Image',style: TextStyle(color: Colors.pink),),),
      ],
    );
  }
}


