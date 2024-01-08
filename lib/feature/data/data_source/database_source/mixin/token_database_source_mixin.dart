import 'package:hive_flutter/hive_flutter.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/injection/injection_container.dart';

mixin TokenDatabaseSourceMixin {
  Future<void> insertToken(Token token) async {
    return await getIt<LazyBox<Token>>().put(1, token);
  }

  Future<void> deleteToken() async {
    return await getIt<LazyBox<Token>>().delete(1);
  }

  Future<Token?> getToken() async {
    return await getIt<LazyBox<Token>>().get(1);
  }
}
