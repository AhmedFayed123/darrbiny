import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/styles.dart';
import '../../controllers/otp_controller.dart';

class OtpBox extends StatefulWidget {
  final int index;

  const OtpBox({super.key, required this.index});

  @override
  State<OtpBox> createState() => _OtpBoxState();
}

class _OtpBoxState extends State<OtpBox> {
  late FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OtpController>();

    return Obx(() {
      final isEmpty = controller.otpDigits[widget.index].isEmpty;
      final isError = controller.showError.value && isEmpty;
      final hasFocus = _focusNode.hasFocus;

      final Color borderColor = isError
          ? Colors.red
          : hasFocus
          ? kSecondaryColor
          : Colors.transparent;

      return Container(
        width: 56.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: !hasFocus
              ? [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            )
          ]
              : [],
          border: Border.all(
            color: borderColor,
            width: isError ? 2 : (hasFocus ? 1.5 : 1),
          ),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            TextFormField(
              focusNode: _focusNode,
              textAlign: TextAlign.center,
              maxLength: 1,
              keyboardType: TextInputType.number,
              style: AppStyles.headingStyle.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: kSecondaryColor, // دايمًا بنفسجي
              ),
              onChanged: (value) {
                controller.updateDigit(widget.index, value);
                if (value.isNotEmpty && widget.index < 4) {
                  FocusScope.of(context).nextFocus();
                } else if (value.isEmpty && widget.index > 0) {
                  FocusScope.of(context).previousFocus();
                }
              },
              decoration: InputDecoration(
                counterText: '',
                filled: true,
                fillColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none, // منخليش TextFormField يرسم البوردر
              ),
            ),
            if (!hasFocus)
              Positioned(
                bottom: 8.h,
                child: Container(
                  width: 24.w,
                  height: 2.h,
                  color: isError ? Colors.red : kSecondaryColor,
                ),
              ),
          ],
        ),
      );
    });
  }
}
