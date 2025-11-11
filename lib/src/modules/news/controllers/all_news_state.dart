import 'package:emehanika_tech/core/failure/failure.dart';
import 'package:emehanika_tech/src/app/models/e_article/e_article.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class AllNewsState extends Equatable {
  final List<EArticle>? articles;
  final List<EArticle>? allArticles;
  final bool loading;
  final Failure? failure;
  final String selectedCategory;
  final String selectedCountry;

  const AllNewsState({
    this.articles,
    this.allArticles,
    this.loading = false,
    this.failure,
    this.selectedCategory = '',
    this.selectedCountry = 'us',
  });

  AllNewsState copyWith({
    List<EArticle>? articles,
    List<EArticle>? allArticles,
    bool? loading,
    Failure? failure,
    String? selectedCategory,
    String? selectedCountry,
  }) =>
      AllNewsState(
        articles: articles ?? this.articles,
        allArticles: allArticles ?? this.allArticles,
        loading: loading ?? this.loading,
        failure: failure ?? this.failure,
        selectedCategory: selectedCategory ?? this.selectedCategory,
        selectedCountry: selectedCountry ?? this.selectedCountry,
      );

  @override
  List<Object?> get props => [
        articles,
        allArticles,
        loading,
        failure,
        selectedCategory,
        selectedCountry,
      ];
}

class AllNewsInitialState extends AllNewsState {
  const AllNewsInitialState({
    required super.articles,
  });
}

enum Category {
  health,
  business,
  entertainment,
  general,
  science,
  sports,
  technology,
  all,
}
