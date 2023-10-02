import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sport_app/Model/models/remote_config_model.dart';
import 'package:sport_app/Model/services/firebase_services/firebase_remote_config_services.dart';

part 'init_state.dart';

class InitCubit extends Cubit<InitState> {
  InitCubit(this.firebaseRemoteConfigService) : super(InitInitial());

  final FirebaseRemoteConfigService firebaseRemoteConfigService;

  RemoteConfigModel? data;

  void getData() {
    emit(Loading());
    final json = firebaseRemoteConfigService.getEventInfoJson();
    data = remoteConfigModelFromJson(json);
    emit(Success());
  }
}
