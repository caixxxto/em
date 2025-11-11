import 'package:emehanika_tech/src/app/ui_kit/widgets/news_card.dart';
import 'package:emehanika_tech/src/modules/news/controllers/all_news_controller.dart';
import 'package:emehanika_tech/src/modules/news/controllers/all_news_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FavoriteNewsScreen extends StatelessWidget {
  const FavoriteNewsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19.0),
        child: BlocBuilder<NewsController, AllNewsState>(
          builder: (context, state) {
            final favoriteArticles = state.allArticles
                    ?.where((article) => article.isFavorite ?? false)
                    .toList() ??
                [];

            if (favoriteArticles.isEmpty) {
              return const Center(
                child: Text(
                  'Нет избранных новостей',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              );
            }

            return ListView.builder(
              itemCount: favoriteArticles.length,
              itemBuilder: (context, index) {
                final article = favoriteArticles[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: NewsCardWidget(
                    context: context,
                    title: article.title,
                    subtitle: article.description ?? '',
                    date: formatDate(article.publishedAt),
                    image: article.urlToImage ?? '',
                    text: article.content ?? '',
                    source: article.source,
                    isFav: article.isFavorite ?? false,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  String formatDate(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      return DateFormat('MM.dd.yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }
}
