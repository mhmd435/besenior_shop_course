part of 'intro_cubit.dart';

class IntroState {
  bool showGetStart;

  IntroState({required this.showGetStart});

  IntroState copyWith({
    bool? newShowGetStart,
  }){
    return IntroState(
        showGetStart: newShowGetStart ?? showGetStart
    );
  }
}
