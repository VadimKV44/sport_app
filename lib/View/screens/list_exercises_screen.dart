import 'package:flutter/material.dart';
import 'package:sport_app/Model/models/exercise_model.dart';
import 'package:sport_app/View/consts/colors.dart';
import 'package:sport_app/View/consts/styles.dart';
import 'package:sport_app/View/widgets/image_alert_dialog_widget.dart';

class ListExercisesScreen extends StatelessWidget {
  const ListExercisesScreen({
    super.key,
    required this.exercises,
  });

  final List<ExerciseModel> exercises;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.kWhiteColor1,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background_image.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
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
                      borderRadius: BorderRadius.circular(16.0),
                      onTap: () {
                        showDialog(context: context, builder: (context) {
                          return ImageAlertDialogWidget(image: exercises[index].image);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset(exercises[index].image, height: 60.0),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: Text(
                                exercises[index].title,
                                style: MainStyles.kBlackColor1W600(20.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
