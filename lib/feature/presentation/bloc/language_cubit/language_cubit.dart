import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';

import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/feature/presentation/bloc/language_cubit/language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  late final ChangeLanguageUseCase _changeLanguageUseCase;

  LanguageCubit(
      ChangeLanguageUseCase changeLanguageUseCase, String initialLanguageCode)
      : super(LanguageState(isOpen: false, languageCode: initialLanguageCode)) {
    _changeLanguageUseCase = changeLanguageUseCase;
  }

  void changeLanguage(String languageCode) async {
    _changeLanguageUseCase.call(ChangeLanguageParams(languageCode)).fold(
        (left) =>
            emit(state.copyWith(isOpen: false, languageCode: state.languageCode)),
        (right) =>
            emit(state.copyWith(isOpen: false, languageCode: languageCode)));
  }

  void changeIsOpen(bool isOpen) => emit(state.copyWith(isOpen: isOpen));

  String languageCode() => state.languageCode;
}
