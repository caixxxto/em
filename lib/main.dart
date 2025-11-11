import 'package:emehanika_tech/src/api_client/client.dart';
import 'package:emehanika_tech/src/app/app.dart';
import 'package:emehanika_tech/src/app/repositories%20/news_repository/news_interface.dart';
import 'package:emehanika_tech/src/app/repositories%20/news_repository/news_repository.dart';
import 'package:emehanika_tech/src/app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final apiClient = ConcreteApiClient();
  final newsRepository = NewsRepository(apiClient);
  final sharedPrefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        Provider<NewsRepositoryInterface>.value(value: newsRepository),
        Provider<SharedPreferences>.value(value: sharedPrefs),
      ],
      child: App(
        apiClient: apiClient,
        router: AppRouter.createRouter(),
        newsRepository: newsRepository,
      ),
    ),
  );
}