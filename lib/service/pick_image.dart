import 'package:image_picker/image_picker.dart';

// Define the PickImage class
class PickImage {
  // Define a method to pick an image from the gallery
  Future<XFile?>? pickImageFromGalllery() async {
    // Use the ImagePicker to pick an image from the gallery
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    // Return the selected image
    return returnedImage;
  }

  // Define a method to pick an image from the camera
  Future<XFile?>? pickImageFromCamera() async {
    // Use the ImagePicker to pick an image from the camera
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    // Return the selected image
    return returnedImage;
  }
}
