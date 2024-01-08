import 'package:dio/dio.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

class NewsUseCase extends UseCase<BasePaginationListResponse<Newness>, NewsUseCaseParams> {
  final NewsRepository newsRepository;

  NewsUseCase(this.newsRepository);

  @override
  Future<Either<Failure, BasePaginationListResponse<Newness>>> call(NewsUseCaseParams params) {
    return newsRepository.getNews(page: params.page, cancelToken: params.cancelToken);
  }
}

class NewsUseCaseParams extends Equatable {
  final int page;
  final CancelToken cancelToken;

  const NewsUseCaseParams(this.page, this.cancelToken);

  @override
  List<Object?> get props => [page, cancelToken];
}
