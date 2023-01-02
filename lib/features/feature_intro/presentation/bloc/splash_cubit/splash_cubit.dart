import 'package:besenior_shop_course/features/feature_intro/repositories/splash_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';
part 'connection_status.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashRepository splashRepository = SplashRepository();

  SplashCubit() : super(
      SplashState(
          connectionStatus: ConnectionInitial()
      ));

  void checkConnectionEvent() async {
    emit(state.copyWith(newConnectionStatus: ConnectionInitial()));

    bool isConnect = await splashRepository.checkConnectivity();

    if(isConnect){
      emit(state.copyWith(newConnectionStatus: ConnectionOn()));
    }else{
      emit(state.copyWith(newConnectionStatus: ConnectionOff()));
    }
  }
}
