import 'package:sport_app/Model/local_storage/data_for_plug/exercises_for_back.dart';
import 'package:sport_app/Model/local_storage/data_for_plug/exercises_for_chest.dart';
import 'package:sport_app/Model/local_storage/data_for_plug/exercises_for_hands.dart';
import 'package:sport_app/Model/local_storage/data_for_plug/exercises_for_press.dart';
import 'package:sport_app/Model/local_storage/data_for_plug/leg_exercises.dart';
import 'package:sport_app/Model/local_storage/data_for_plug/shoulder_exercises.dart';
import 'package:sport_app/Model/models/exercise_model.dart';
import 'package:sport_app/Model/models/remote_config_model.dart';
import 'package:sport_app/Model/services/firebase_services/firebase_remote_config_services.dart';

class Repository {

  Future<RemoteConfigModel> getUrl(FirebaseRemoteConfigService firebaseRemoteConfigService) async {
    final json = firebaseRemoteConfigService.getEventInfoJson();
    return remoteConfigModelFromJson(json);
  }

  static List<ExerciseModel> getExercisesForChest() {
    return exercisesForChest;
  }

  static List<ExerciseModel> getExercisesForBack() {
    return exercisesForBack;
  }

  static List<ExerciseModel> getExercisesForLeg() {
    return exercisesForLeg;
  }

  static List<ExerciseModel> getExercisesForHands() {
    return exercisesForHands;
  }

  static List<ExerciseModel> getShoulderExercises() {
    return shoulderExercises;
  }

  static List<ExerciseModel> getExercisesForPress() {
    return exercisesForPress;
  }
}