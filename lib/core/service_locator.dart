import 'package:emehanika_tech/src/api_client/client.dart';
import 'package:emehanika_tech/src/app/repositories%20/news_repository/news_interface.dart';
import 'package:emehanika_tech/src/app/repositories%20/news_repository/news_repository.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton<ConcreteApiClient>(() => ConcreteApiClient());

  sl.registerLazySingleton<NewsRepositoryInterface>(
        () => NewsRepository(sl<ConcreteApiClient>()),
  );
}