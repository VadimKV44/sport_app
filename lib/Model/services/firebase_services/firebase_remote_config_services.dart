import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfigService {
  final FirebaseRemoteConfig firebaseRemoteConfig;

  const FirebaseRemoteConfigService({
    required this.firebaseRemoteConfig,
  });

  Future<bool> init() async {
    bool loaded = false;
    try {
      await firebaseRemoteConfig.ensureInitialized();
      await firebaseRemoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(seconds: 5),
        ),
      );
      await firebaseRemoteConfig.fetchAndActivate();
      loaded = true;
    } on FirebaseException catch (e, st) {
      loaded = false;
    }

    return loaded;
  }

  String getEventInfoJson() {
    return firebaseRemoteConfig.getString('url');
  }
}
