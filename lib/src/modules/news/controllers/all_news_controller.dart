import 'dart:async';

import 'package:emehanika_tech/src/app/logger/app_logger.dart';
import 'package:emehanika_tech/src/app/models/e_article/e_article.dart';
import 'package:emehanika_tech/src/app/repositories%20/news_repository/news_interface.dart';
import 'package:emehanika_tech/src/modules/news/controllers/all_news_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsController extends Cubit<AllNewsState> {
  final NewsRepositoryInterface _repository;
  final SharedPreferences sharedPrefs;
  late final _appLogger = AppLogger(where: '$this');
  static const String _favoritesKey = 'favorite_news_ids';

  NewsController(
    this._repository,
    this.sharedPrefs,
  ) : super(const AllNewsState());

  Future<void> init() async {
    await getNews();
    initFavorites(sharedPrefs);
  }

  void _changeLoadingStatus(bool loading) =>
      emit(state.copyWith(loading: loading));

  Future<void> addToFavorite(String id) async {
    final List<String> favorites = getFavorites(sharedPrefs);

    if (!favorites.contains(id)) {
      favorites.add(id);
      await sharedPrefs.setStringList(_favoritesKey, favorites);
      _updateArticleFavoriteStatus(id, true);
    } else {
      favorites.remove(id);
      await sharedPrefs.setStringList(_favoritesKey, favorites);
      _updateArticleFavoriteStatus(id, false);
    }
  }

  List<String> getFavorites(SharedPreferences sharedPrefs) {
    return sharedPrefs.getStringList(_favoritesKey) ?? [];
  }

  void initFavorites(SharedPreferences sharedPrefs) {
    final favNews = sharedPrefs.getStringList(_favoritesKey) ?? [];

    for (var i = 0; i < favNews.length; i++) {
      _updateArticleFavoriteStatus(favNews[i], true);
    }
  }

  void _updateArticleFavoriteStatus(String articleId, bool isFavorite) {
    final currentState = state;

    // Обновляем и allArticles, и articles с категорией
    List<EArticle>? updatedAllArticles;
    List<EArticle>? updatedArticles;

    if (currentState.allArticles != null) {
      updatedAllArticles = currentState.allArticles!.map((article) {
        final matches = article.url == articleId ||
            (article.source.id != null && article.source.id == articleId) ||
            article.source.name == articleId;

        if (matches) {
          return article.copyWith(isFavorite: isFavorite);
        }
        return article;
      }).toList();
    }

    if (currentState.articles != null) {
      updatedArticles = currentState.articles!.map((article) {
        final matches = article.url == articleId ||
            (article.source.id != null && article.source.id == articleId) ||
            article.source.name == articleId;

        if (matches) {
          return article.copyWith(isFavorite: isFavorite);
        }
        return article;
      }).toList();
    }

    emit(currentState.copyWith(
      articles: updatedArticles ?? currentState.articles,
      allArticles: updatedAllArticles ?? currentState.allArticles,
    ));
  }

  Future<void> getNews({
    String? category = '',
    String? country = 'us',
    String search = '',
  }) async {
    _changeLoadingStatus(true);

    // Сразу переключаем категорию, чтобы не зависало
    if (category != '') {
      emit(state.copyWith(
        selectedCategory: category ?? '',
      ));
    }

    final response = await _repository.getNews(category, country, search);

    response.fold((failure) {
      _appLogger.logError(
        failure.message,
        stackTrace: failure.stackTrace,
        lexicalScope: 'getNews()',
      );

      emit(
        state.copyWith(
          failure: failure,
          loading: false,
        ),
      );
    }, (articles) {
      emit(
        state.copyWith(
          articles: articles,
          allArticles: _mergeArticles(state.allArticles, articles),
          loading: false,
        ),
      );

      if (kDebugMode) {
        print(state.allArticles?.length);
      }
    });
  }

  List<EArticle> _mergeArticles(
      List<EArticle>? existingArticles, List<EArticle> newArticles) {
    if (existingArticles == null || existingArticles.isEmpty) {
      return newArticles;
    }

    final merged = List<EArticle>.from(existingArticles);

    for (final newArticle in newArticles) {
      // Проверяем, нет ли уже такой статьи
      final exists = merged.any((existing) =>
          existing.url == newArticle.url || existing.title == newArticle.title);

      if (!exists) {
        merged.add(newArticle);
      }
    }

    return merged;
  }

  // не актуально, т.к. api не отдает по странам
  void selectCountry(String country) {
    emit(state.copyWith(selectedCountry: country));
    getNews(category: state.selectedCategory, country: country);
  }
}
