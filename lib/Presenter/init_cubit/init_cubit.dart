import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:meta/meta.dart';
import 'package:sport_app/Model/local_storage/shared_preferences.dart';
import 'package:sport_app/Model/services/firebase_services/firebase_remote_config_services.dart';
import 'package:sport_app/Presenter/repository.dart';

part 'init_state.dart';

class InitCubit extends Cubit<InitState> {
  InitCubit(this.firebaseRemoteConfigService) : super(InitInitial());

  final FirebaseRemoteConfigService firebaseRemoteConfigService;
  Repository repository = Repository();
  String? remoteConfigUrl;
  bool loaded = false;

  void checkLoad(bool load) {
    loaded = load;
    if (!load) {
      emit(ShowPlug());
    }
  }

  void checkUrl() async {
    if (loaded) {
      emit(Loading());
      String data = await LocalStorage.getUrl();
      if (data.isEmpty) {
        getUrl();
      } else {
        remoteConfigUrl = data;
        emit(ShowWebView());
      }
    }
  }

  void getUrl() async {
    remoteConfigUrl = await repository.getUrl(firebaseRemoteConfigService);
    bool openPlug = await getDeviceInfo();
    if ((remoteConfigUrl ?? '').isEmpty || openPlug) {
      emit(ShowPlug());
    } else {
      await LocalStorage.setUrl(remoteConfigUrl ?? '');
      emit(ShowWebView());
    }
  }


  Future<bool> getDeviceInfo() async {
    bool openPlug = false;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    try {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      if (!iosInfo.isPhysicalDevice) {
        openPlug = true;
      }
    } catch (_) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.brand == 'google' || !androidInfo.isPhysicalDevice) {
        openPlug = true;
      }
    }

    return openPlug;
  }
}

