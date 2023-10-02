import 'package:flutter/material.dart';
import 'package:sport_app/Presenter/repository.dart';
import 'package:sport_app/View/consts/colors.dart';
import 'package:sport_app/View/consts/strings.dart';
import 'package:sport_app/View/consts/styles.dart';
import 'package:sport_app/View/screens/list_exercises_screen.dart';
import 'package:sport_app/View/widgets/custom_button_widget.dart';

class BasicExercisesScreen extends StatelessWidget {
  const BasicExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.kWhiteColor1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
          child: ListView(
            children: [
              Text(
                Strings.basicExercises,
                style: MainStyles.kBlackColor1W600(30.0),
              ),
              const SizedBox(height: 20.0),
              CustomButtonWidget(
                text: Strings.exercisesForChest,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ListExercisesScreen(exercises: Repository.getExercisesForChest())));
                },
              ),
              const SizedBox(height: 20.0),
              CustomButtonWidget(
                text: Strings.exercisesForBack,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ListExercisesScreen(exercises: Repository.getExercisesForBack())));
                },
              ),
              const SizedBox(height: 20.0),
              CustomButtonWidget(
                text: Strings.legExercises,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ListExercisesScreen(exercises: Repository.getExercisesForLeg())));
                },
              ),
              const SizedBox(height: 20.0),
              CustomButtonWidget(
                text: Strings.exercisesForHands,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ListExercisesScreen(exercises: Repository.getExercisesForHands())));
                },
              ),
              const SizedBox(height: 20.0),
              CustomButtonWidget(
                text: Strings.shoulderExercises,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ListExercisesScreen(exercises: Repository.getShoulderExercises())));
                },
              ),
              const SizedBox(height: 20.0),
              CustomButtonWidget(
                text: Strings.exercisesForPress,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ListExercisesScreen(exercises: Repository.getExercisesForPress())));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
