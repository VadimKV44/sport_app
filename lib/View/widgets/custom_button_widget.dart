import 'package:flutter/material.dart';
import 'package:sport_app/View/consts/colors.dart';
import 'package:sport_app/View/consts/styles.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MainColors.kWhiteColor1,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: MainColors.kBlackColor1.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: MainStyles.kBlackColor1W400(20.0),
            ),
          ),
        ),
      ),
    );
  }
}
