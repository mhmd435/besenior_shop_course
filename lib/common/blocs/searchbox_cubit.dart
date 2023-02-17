import 'package:bloc/bloc.dart';


class SearchboxCubit extends Cubit<bool> {
  SearchboxCubit() : super(true);

  void changeVisibility(bool newValue){
    emit(newValue);
  }
}
