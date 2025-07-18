import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../constant/colors.dart';
import '../../constant/sizes.dart';

class CircleLoading extends StatelessWidget {
  const CircleLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      color: kAmberColor, // Set the color to gold (amber)
      size: Sizes.buttonHeightMedium, // Set the size of the spinner
    );
  }
}
