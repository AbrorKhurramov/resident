import 'package:equatable/equatable.dart';

class LanguageState extends Equatable {
  final bool isOpen;
  final String languageCode;

  const LanguageState({required this.isOpen, required this.languageCode});

  LanguageState copyWith({bool? isOpen, String? languageCode}) {
    return LanguageState(
        isOpen: isOpen ?? this.isOpen,
        languageCode: languageCode ?? this.languageCode);
  }

  @override
  List<Object?> get props => [isOpen, languageCode];
}
