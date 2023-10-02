import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:meta/meta.dart';
import 'package:sport_app/Model/local_storage/shared_preferences.dart';
import 'package:sport_app/Model/models/remote_config_model.dart';
import 'package:sport_app/Model/services/firebase_services/firebase_remote_config_services.dart';

part 'init_state.dart';

class InitCubit extends Cubit<InitState> {
  InitCubit(this.firebaseRemoteConfigService) : super(InitInitial());

  final FirebaseRemoteConfigService firebaseRemoteConfigService;

  RemoteConfigModel? remoteConfig;

  void checkUrl() async {
    emit(Loading());
    String data = await LocalStorage.getUrl();
    if (data.isEmpty) {
      getUrl();
    } else {
      remoteConfig = RemoteConfigModel(url: data);
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none && connectivityResult != ConnectivityResult.bluetooth) {
        emit(ShowWebView());
      } else {
        emit(Error());
      }
    }
  }

  void getUrl() async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none && connectivityResult != ConnectivityResult.bluetooth) {
        final json = firebaseRemoteConfigService.getEventInfoJson();
        remoteConfig = remoteConfigModelFromJson(json);
        bool openPlug = await getDeviceInfo();
        if ((remoteConfig?.url ?? '').isEmpty || openPlug) {
          emit(ShowPlug());
        } else {
          await LocalStorage.setUrl(remoteConfig?.url ?? '');
          emit(ShowWebView());
        }
      }
    } on SocketException catch (_) {
      emit(Error());
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
