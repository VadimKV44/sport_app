import 'package:flutter/material.dart';
import 'package:sport_app/View/consts/strings.dart';
import 'package:sport_app/View/consts/styles.dart';
import 'package:sport_app/View/screens/basic_exercises_screen.dart';
import 'package:sport_app/View/widgets/custom_button_widget.dart';

class PlugWidget extends StatelessWidget {
  const PlugWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
      child: Column(
        children: [
          Text(
            Strings.basicExercises,
            style: MainStyles.kWhiteColor1W600(30.0),
          ),
          const SizedBox(height: 20.0),
          Text(
            Strings.description,
            style: MainStyles.kWhiteColor1W400(24.0),
          ),
          const SizedBox(height: 40.0),
          CustomButtonWidget(
            text: Strings.seeBasicExercises,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const BasicExercisesScreen()));
            },
          ),
        ],
      ),
    );
  }
}
