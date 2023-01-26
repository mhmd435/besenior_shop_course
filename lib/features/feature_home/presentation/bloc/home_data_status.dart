part of 'home_cubit.dart';

@immutable
abstract class HomeDataStatus {}

class HomeDataInitial extends HomeDataStatus {}

class HomeDataLoading extends HomeDataStatus {}

class HomeDataCompleted extends HomeDataStatus {
  final HomeModel homeModel;
  HomeDataCompleted(this.homeModel);
}

class HomeDataError extends HomeDataStatus {
  final String errorMessage;
  HomeDataError(this.errorMessage);
}
