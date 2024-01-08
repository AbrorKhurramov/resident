import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

abstract class RepositoryCubit<T> extends Cubit<T> {
  final CancelToken cancelToken = CancelToken();

  RepositoryCubit(T t) : super(t);

  void dispose() {
    cancelToken.cancel();
  }

   @override
   void emit(T state) {
     if (isClosed) {
       return;
     }
     super.emit(state);
   }

  @override
  Future<void> close() async {
    dispose();
    super.close();
  }
}
