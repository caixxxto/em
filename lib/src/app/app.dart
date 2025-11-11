import 'package:emehanika_tech/src/api_client/client.dart';
import 'package:emehanika_tech/src/app/repositories%20/news_repository/news_interface.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class App extends StatelessWidget {
  final ConcreteApiClient apiClient;
  final GoRouter router;
  final NewsRepositoryInterface newsRepository;

  const App({
    super.key,
    required this.apiClient,
    required this.router,
    required this.newsRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}