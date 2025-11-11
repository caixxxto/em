import 'package:dartz/dartz.dart';
import 'package:emehanika_tech/src/app/errors/api/api_errors.dart';
import 'package:emehanika_tech/src/app/models/e_article/e_article.dart';

import '../../../../core/failure/failure.dart';
import '../../../api_client/client.dart';
import '../base_repository_interface.dart';

abstract interface class NewsRepositoryInterface
    implements BaseRepositoryInterface {
  @override
  ConcreteApiClient get apiClient;

  ErrorHandler get errorHandler;

  Future<Either<Failure, List<EArticle>>> getNews(String? category, String? country, String? search);
}
