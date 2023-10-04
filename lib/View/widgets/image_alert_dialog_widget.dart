import 'package:flutter/material.dart';
import 'package:sport_app/View/consts/colors.dart';

class ImageAlertDialogWidget extends StatelessWidget {
  const ImageAlertDialogWidget({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: MainColors.kWhiteColor1,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image.asset(image),
        ),
      ),
    );
  }
}
