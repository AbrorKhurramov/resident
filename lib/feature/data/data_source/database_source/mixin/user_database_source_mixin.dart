import 'package:hive_flutter/hive_flutter.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/injection/injection_container.dart';

mixin UserDatabaseSourceMixin {
  Future<void> insertUser(User user) async {
    return await getIt<LazyBox<User>>().put(1, user);

  }

  Future<void> deleteUser() async {
    return await getIt<LazyBox<User>>().delete(1);
  }

  Future<User?> getUser() async {
    return await getIt<LazyBox<User>>().get(1);
  }
}
