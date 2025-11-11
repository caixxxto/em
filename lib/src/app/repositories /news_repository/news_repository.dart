import 'package:dartz/dartz.dart';
import 'package:emehanika_tech/core/failure/failure.dart';
import 'package:emehanika_tech/src/api_client/client.dart';
import 'package:emehanika_tech/src/api_client/response_code.dart';
import 'package:emehanika_tech/src/app/errors/api/api_errors.dart';
import 'package:emehanika_tech/src/app/errors/news_errors/news_errors_handler.dart';
import 'package:emehanika_tech/src/app/models/e_article/e_article.dart';
import 'package:emehanika_tech/src/app/models/e_news/e_news.dart';
import 'package:emehanika_tech/src/app/repositories%20/news_repository/news_interface.dart';

const apiKey = '2eb85b39501e4b28a8d026ee0c87444e';

class NewsRepository implements NewsRepositoryInterface {

  final ConcreteApiClient _apiClient;

  const NewsRepository(
    this._apiClient,
  );

  @override
  ConcreteApiClient get apiClient => _apiClient;

  @override
  ErrorHandler get errorHandler => const NewsErrorHandler();

  @override
  Future<Either<Failure, List<EArticle>>> getNews(
    String? category,
    String? country,
    String? search,
  ) async {
    try {
      String api = 'country=$country&apiKey=$apiKey';

      if (category != null && category != '') {
        api += '&category=$category';
      }

      if (search != null && search != '') {
        api += '&q=$search';
      }

      final response = await apiClient.apiClient
          .get('/top-headlines?$api');

      if (response.statusCode != ResponseCode.OK) {
        return Left(
          errorHandler.handleError(
            response.data,
          ),
        );
      }

      final ENews news = ENews.fromJson(response.data);

      return Right(news.articles);
    } catch (error, stackTrace) {
      return Left(
        errorHandler.handleError(
          error,
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
