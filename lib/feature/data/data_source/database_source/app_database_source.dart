import 'package:resident/feature/data/data_source/database_source/mixin/token_database_source_mixin.dart';
import 'package:resident/feature/data/data_source/database_source/mixin/user_database_source_mixin.dart';

abstract class AppDatabaseSource implements UserDatabaseSourceMixin , TokenDatabaseSourceMixin {}

class AppDatabaseSourceImpl
    with UserDatabaseSourceMixin, TokenDatabaseSourceMixin
    implements AppDatabaseSource {}
