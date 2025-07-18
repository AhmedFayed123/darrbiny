import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/styles.dart';
import 'line_widget.dart';

class OrLineWidget extends StatelessWidget {
  const OrLineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           const LineWidget(),
           Text(
             'or',
             style: AppStyles.textStyle12regular,
           ),
           const LineWidget(),
         ],
      ),
    );  }
}
