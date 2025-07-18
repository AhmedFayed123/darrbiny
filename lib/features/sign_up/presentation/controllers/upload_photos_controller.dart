import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadPhotosController extends GetxController{
  Rx<File?> selectedDrivingImage = Rx<File?>(null);

  Future<void> pickDrivingImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      selectedDrivingImage.value = File(picked.path);
    }
  }
}