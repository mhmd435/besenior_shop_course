import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'intro_state.dart';

class IntroCubit extends Cubit<IntroState> {
  IntroCubit() : super(
      IntroState(
          showGetStart: false,
      ));

  void changeGetStart(bool value) => emit(state.copyWith(newShowGetStart: value));
}
