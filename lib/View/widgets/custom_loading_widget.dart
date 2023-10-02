import 'package:flutter/material.dart';
import 'package:sport_app/View/consts/colors.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.transparent,
        color: MainColors.kBlackColor1,
        strokeWidth: 4.0,
      ),
    );
  }
}
