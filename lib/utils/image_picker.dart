
import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File> pickImageFromGallery() async {
  try {

    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if(image == null) {
      throw Exception('No Image Selected');
    } 

    final File pickedImage = File(image.path);

    return pickedImage;
    
  } catch (e) {
    rethrow;
  }
  
}