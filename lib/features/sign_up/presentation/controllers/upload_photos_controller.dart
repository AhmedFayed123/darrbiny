import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/server_failures.dart';
import '../../data/repos/sign_up_repo_impl.dart';

class UploadPhotosController extends GetxController {
  Rx<File?> selectedDrivingImage = Rx<File?>(null);
  Rx<File?> selectedNationalIdImage = Rx<File?>(null);
  Rx<File?> selectedCarImage = Rx<File?>(null);

  final SignUpRepoImpl signUpRepo = SignUpRepoImpl();

  Future<void> pickDrivingImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      selectedDrivingImage.value = File(picked.path);
    }
  }

  Future<void> pickNationalIdImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      selectedNationalIdImage.value = File(picked.path);
    }
  }

  Future<void> pickCarImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      selectedCarImage.value = File(picked.path);
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> uploadPhotos() async {
    if (selectedCarImage.value == null ||
        selectedDrivingImage.value == null ||
        selectedNationalIdImage.value == null) {
      return left(ServerFailure("يرجى اختيار جميع الصور المطلوبة"));
    }

    return await signUpRepo.postRequestWithPhotos(
      id: 2,
      carImage: selectedCarImage.value!,
      drivingImage: selectedDrivingImage.value!,
      nationalIdImage: selectedNationalIdImage.value!,
    );
  }
}
