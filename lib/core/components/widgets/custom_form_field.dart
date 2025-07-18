import 'package:country_picker/country_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/colors.dart';
import '../../constant/styles.dart';

class CustomFormField extends StatefulWidget {
  CustomFormField({
    super.key,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.maxLines = 1,
    this.maxLength,
    this.prefixIcon, // للحقل العادى
    this.textInputAction,
    this.onChanged,
    this.borderColor = kBorderColor,
    this.textStyle,
    // ↓ منتقى الدول
    this.isCountryPicker = false,
    this.initialCountryCode,
    this.onCountryChanged,
  });

  // أساسيات
  final String labelText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final int? maxLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;

  // مظهر
  final Color borderColor;
  final TextStyle? textStyle;
  final TextStyle labelStyle = AppStyles.labelStyle;

  // منتقى الدول
  final bool isCountryPicker;
  final String? initialCountryCode;
  final void Function(Country)? onCountryChanged;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  late Country _country;

  @override
  void initState() {
    super.initState();
    _country = Country.parse(widget.initialCountryCode ?? 'EG');
  }

  void _pickCountry() => showCountryPicker(
    context: context,
    favorite: const ['EG', 'SA', 'AE'],
    showPhoneCode: true,
    onSelect: (c) {
      setState(() => _country = c);
      widget.onCountryChanged?.call(c);
    },
  );

  @override
  Widget build(BuildContext context) {
    // ◀️ Prefix: إمّا علم + كود أو أيقونة عاديّة
    Widget? prefix;
    if (widget.isCountryPicker) {
      prefix = GestureDetector(
        onTap: _pickCountry,
        child: Padding(
          padding: EdgeInsets.only(right: 16.w), // ← padding داخلي حول العلم والكود
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_country.flagEmoji, style: AppStyles.labelStyle),
              SizedBox(width: 4.w),
              Text('+${_country.phoneCode}', style: AppStyles.labelStyle),
              SizedBox(width: 6.w),
              const Icon(Icons.keyboard_arrow_down, size: 20),
            ],
          ),
        ),
      );
    } else {
      prefix = widget.prefixIcon;
    }

    return TextFormField(
      controller: widget.controller,
      keyboardType:
      widget.isCountryPicker ? TextInputType.phone : widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        // 🏷️ الليبل
        labelText: widget.labelText,
        labelStyle: widget.labelStyle,
        // ➡️ الـ prefix
        // داخل InputDecoration
        prefixIconConstraints: const BoxConstraints(
          minWidth: 40,   // ← يترك حوالى 16‑20 بكسل حشو قبل المحتوى
          minHeight: 0,
        ),
        prefixIcon: prefix,
        prefixIconColor: kGray300,

        // 🎨 الحشوات الداخلية
        contentPadding:
        EdgeInsets.only(top: 14.h,bottom: 15.h,), // ← الجديد
        // 🎨 الحدود
        border: _border,
        enabledBorder: _border,
        focusedBorder: _border.copyWith(
          borderSide: BorderSide(color: widget.borderColor, width: 2),
        ),
        isDense: true,
      ),
      style: widget.textStyle,
      validator: widget.validator,
      obscureText: widget.obscureText,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
    );
  }

  OutlineInputBorder get _border => OutlineInputBorder(
    borderRadius: BorderRadius.circular(16.r),
    borderSide: BorderSide(color: widget.borderColor),
  );
}
