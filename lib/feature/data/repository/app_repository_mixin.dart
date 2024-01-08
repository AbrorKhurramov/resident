import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';

mixin AppRepositoryMixin {
  Either<Failure, T> getEitherResponse<T>(response) {
    if (response.isRight) {
      return Right(response.right);
    } else {
      if (response.left is TokenExpireException) {
        return Left(TokenExpiryFailure());
      } else if (response.left is ServerException) {
        return Left(ServerFailure(
            message: (response.left as ServerException).message,
            statusCode: (response.left as ServerException).statusCode));
      } else if (response.left is NetworkException) {
        return Left(NetworkFailure());
      } else if (response.left is ConnectionTimeOutException) {
        return Left(ConnectionTimeOutFailure());
      }
      else if (response.left is CancelException) {
        return Left(CancelFailure());
      }
      else {
        return Left(JsonCastFailure(
            message: (response.left as JsonCastException).message));
      }
    }
  }
}
