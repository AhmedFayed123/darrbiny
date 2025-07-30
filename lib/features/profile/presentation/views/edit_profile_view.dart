import 'package:darrbiny/core/components/widgets/custom_app_bar.dart';
import 'package:darrbiny/core/components/widgets/custom_button.dart';
import 'package:darrbiny/core/constant/styles.dart';
import 'package:darrbiny/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../controllers/learner_profile_controller.dart';

class EditProfileView extends StatelessWidget {
  EditProfileView({super.key});

  final LearnerProfileController controller = Get.find();

  final TextEditingController nameController = TextEditingController();

  final Rx<File?> imageFile = Rx<File?>(null);

  @override
  Widget build(BuildContext context) {
    nameController.text = controller.learnerProfile.value?.name ?? '';

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

                final profileImageUrl = controller.learnerProfile.value?.profileImageUrl;
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
              _readonlyField(hint: controller.learnerProfile.value?.email ?? ''),
              _sectionTitle('رقم الهاتف'),
              _readonlyField(hint: controller.learnerProfile.value?.phone ?? ''),
              _sectionTitle('كلمة المرور'),
              _readonlyField(hint: '********'),
              _sectionTitle('تأكيد كلمة المرور'),
              _readonlyField(hint: '********'),
              SizedBox(height: 24.h),
              CustomButton(
                text: 'حفظ',
                onPressed: () async {
                  final name = nameController.text.trim();
                  final path = imageFile.value?.path ?? '';

                  if (name.isEmpty) return;

                  controller.updateProfile(name: name, imagePath: path);
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
