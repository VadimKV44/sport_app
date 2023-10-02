import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/Model/services/firebase_services/firebase_remote_config_services.dart';
import 'package:sport_app/Presenter/init_cubit/init_cubit.dart';
import 'package:sport_app/View/screens/home_screen.dart';
import 'package:sport_app/Model/services/firebase_services/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final firebaseRemoteConfigServices = FirebaseRemoteConfigService(firebaseRemoteConfig: FirebaseRemoteConfig.instance);
  await firebaseRemoteConfigServices.init();

  runApp(MyApp(firebaseRemoteConfigService: firebaseRemoteConfigServices));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.firebaseRemoteConfigService});

  final FirebaseRemoteConfigService firebaseRemoteConfigService;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InitCubit>(create: (context) => InitCubit(firebaseRemoteConfigService)),
      ],
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
