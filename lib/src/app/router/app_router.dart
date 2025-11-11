import 'package:emehanika_tech/src/modules/main/screens/main_screen.dart';
import 'package:emehanika_tech/src/modules/news/screens/all_news_screen.dart';
import 'package:emehanika_tech/src/modules/news_card/screens/news_card_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: '/main',
      routes: [
        GoRoute(
          path: '/main',
          name: 'main',
          builder: (context, state) => const MainNewsScreen(),
        ),
        GoRoute(
          path: '/news',
          name: 'news',
          builder: (context, state) => const AllNewsScreen(),
        ),
        GoRoute(
          path: '/news_card',
          name: 'news_card',
          builder: (context, state) {
            final newsData = state.extra as Map<String, dynamic>? ?? {};
            return NewsCardScreen(
              title: newsData['title'] ?? '',
              subtitle: newsData['subtitle'] ?? '',
              image: newsData['image'] ?? '',
              date: newsData['date'] ?? '',
              text: newsData['text'] ?? '',
              source: newsData['source'] ?? '',
              isFav: newsData['isFav'] ?? false,
              controller: newsData['controller'],
            );
          },
        ),
      ],
    );
  }
}
