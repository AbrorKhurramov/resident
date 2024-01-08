import 'package:flutter_bloc/flutter_bloc.dart';

class NotInternetCubit extends Cubit<bool> {
  NotInternetCubit(bool initialState) : super(initialState);

  void changeState(bool isConnected) {
    if (state != isConnected) emit(isConnected);
  }
}
