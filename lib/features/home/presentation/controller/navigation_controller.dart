import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../exercises/presentation/views/exercises_view.dart';
import '../../../message/presentation/views/message_view.dart';
import '../../../profile/presentation/views/profile_view.dart';
import '../views/widgets/home_view_body.dart';

class NavigationController extends GetxController{
  final RxInt currentIndex = 0.obs;

  final List<Widget> pages = [
    HomeViewBody(),
    ExercisesView(),
    MessageView(),
    ProfileView(),
  ];

  void changeIndex(int index) => currentIndex.value = index;
}

