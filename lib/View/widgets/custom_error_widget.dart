import 'package:flutter/material.dart';
import 'package:sport_app/View/consts/strings.dart';
import 'package:sport_app/View/consts/styles.dart';
import 'package:sport_app/View/widgets/custom_button_widget.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.onTap,
  });

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            Strings.internetError,
            textAlign: TextAlign.center,
            style: MainStyles.kGreyColor1W600(24.0),
          ),
          const SizedBox(height: 20.0),
          CustomButtonWidget(
            text: Strings.reboot,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
