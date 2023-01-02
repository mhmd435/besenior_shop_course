part of 'splash_cubit.dart';

class SplashState {
  ConnectionStatus connectionStatus;

  SplashState({required this.connectionStatus});

  SplashState copyWith({
    ConnectionStatus? newConnectionStatus,
  }){
    return SplashState(
        connectionStatus: newConnectionStatus ?? connectionStatus
    );
  }
}

