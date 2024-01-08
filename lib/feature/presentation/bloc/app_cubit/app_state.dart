import 'package:equatable/equatable.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class AppState extends Equatable {
  final User? user;
  final bool isAuthorization;


  const AppState({this.user, required this.isAuthorization});

  AppState copyWith({User? user, bool? isAuthorization}) {
    return AppState(
        user: user,
        isAuthorization: isAuthorization ?? this.isAuthorization);
  }

  String getActiveApartmentId() {
    return user!.getActiveApartment().id;
  }

  @override
  List<Object?> get props => [user, isAuthorization];
}
