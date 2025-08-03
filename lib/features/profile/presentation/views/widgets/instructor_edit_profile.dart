import 'dart:io';

import 'package:darrbiny/features/profile/presentation/controllers/instructor_profile_controller.dart';
import 'package:darrbiny/features/sign_up/presentation/views/widgets/upload_driving_photo.dart';
import 'package:darrbiny/features/sign_up/presentation/views/widgets/upload_national_id_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/components/widgets/custom_app_bar.dart';
import '../../../../../core/components/widgets/custom_button.dart';
import '../../../../../core/constant/styles.dart';
import '../../../../../generated/assets.dart';

class InstructorEditProfile extends StatelessWidget {
  InstructorEditProfile({super.key});

  final InstructorProfileController controller = Get.find();

  final TextEditingController nameController = TextEditingController();

  final Rx<File?> imageFile = Rx<File?>(null);

  @override
  Widget build(BuildContext context) {
    nameController.text = controller.instructorProfile.value?.name ?? '';

    final double size = 100;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(title: 'حسابي'),
              SizedBox(height: 24.h),
              Obx(() {
                final image = imageFile.value;

                final profileImageUrl = controller.instructorProfile.value?.profileImageUrl;
                final defaultImage = (profileImageUrl != null && profileImageUrl.isNotEmpty)
                    ? profileImageUrl
                    : Assets.imagesAvatargroup;

                final isNetwork = defaultImage.startsWith('http');

                return Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: size / 2,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: image != null
                            ? FileImage(image)
                            : (isNetwork
                            ? NetworkImage(defaultImage)
                            : AssetImage(defaultImage)) as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 6,
                        child: GestureDetector(
                          onTap: () async {
                            final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
                            if (picked != null) {
                              imageFile.value = File(picked.path);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.deepPurple,
                            ),
                            padding: const EdgeInsets.all(6),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(height: 32.h),
              _sectionTitle('الاسم'),
              _editableField(controller: nameController),
              _sectionTitle('البريد الالكتروني'),
              _readonlyField(hint: controller.instructorProfile.value?.email ?? ''),
              _sectionTitle('رقم الهاتف'),
              _readonlyField(hint: controller.instructorProfile.value?.phone ?? ''),
              _sectionTitle('كلمة المرور'),
              _readonlyField(hint: '********'),
              _sectionTitle('تأكيد كلمة المرور'),
              _readonlyField(hint: '********'),
              SizedBox(height: 24.h),
              _updateDocumentsNote(),
              SizedBox(height: 24.h),
              CustomButton(
                text: 'حفظ',
                onPressed: () async {
                  final name = nameController.text.trim();
                  final path = imageFile.value?.path ?? '';

                  if (name.isEmpty) return;

                  controller.updateInstructorProfile(name: name, imagePath: path);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(title, style: AppStyles.textStyle14500),
    );
  }

  Widget _updateDocumentsNote() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'إذا كنت ترغب في تعديل أو إضافة بيانات السيارة أو الهوية الوطنية أو رخصة القيادة، اضغط على الزر أدناه:',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Get.to(UploadDrivingPhoto());
            },
            child: Text(
              'تعديل أو إضافة المستندات',
              style: TextStyle(fontSize: 16.sp),
            ),
          ),
        ),
      ],
    );
  }

  Widget _editableField({required TextEditingController controller}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(border: InputBorder.none),
        style: TextStyle(color: Colors.black, fontSize: 14.sp),
      ),
    );
  }

  Widget _readonlyField({required String hint}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(border: InputBorder.none, hintText: hint),
        style: TextStyle(color: Colors.grey, fontSize: 14.sp),
      ),
    );
  }
}
