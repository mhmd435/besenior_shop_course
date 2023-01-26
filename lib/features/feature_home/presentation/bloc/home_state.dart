part of 'home_cubit.dart';

class HomeState {
  HomeDataStatus homeDataStatus;

  HomeState({
    required this.homeDataStatus
  });

  HomeState copyWith({
    HomeDataStatus? newHomeDataStatus,
}){
    return HomeState(
        homeDataStatus: newHomeDataStatus ?? homeDataStatus
    );
  }
}
