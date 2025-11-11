import 'app_router.dart';

export 'app_router.dart';

class AppRouterProvider {
  static final AppRouter _instance = AppRouter();
  static AppRouter get instance => _instance;

  AppRouterProvider._();
}
