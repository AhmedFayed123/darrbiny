
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/colors.dart';
import '../../settings/theme.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.tabBarViewChildren,
    this.tabBarViewHeight = 295.0,
  });

  final List<Tab> tabs;
  final List<Widget> tabBarViewChildren;
  final double tabBarViewHeight;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          TabBar(

            labelColor: kWhiteColor,
            unselectedLabelColor: kGreyColor,
            indicatorColor: kAmberColor,
            tabs: tabs,
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: tabBarViewHeight.h,
            child: TabBarView(
              children: tabBarViewChildren,
            ),
          ),
        ],
      ),
    );
  }
}
