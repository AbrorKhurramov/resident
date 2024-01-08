import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardCubit extends Cubit<int> {
  DashboardCubit() : super(1);

  void changePage(int page) => emit(page);
}
