import 'package:flutter/material.dart';
import 'package:sport_app/View/consts/strings.dart';
import 'package:sport_app/View/consts/styles.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        Strings.internetError,
        textAlign: TextAlign.center,
        style: MainStyles.kGreyColor1W600(24.0),
      ),
    );
  }
}
