import 'package:dio/dio.dart';

class ConcreteApiClient {
  ConcreteApiClient() {
    _setupApiClient();
  }

  late final Dio apiClient;

  void _setupApiClient() {
    apiClient = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/v2',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
  }
}