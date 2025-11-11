// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'e_news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ENews _$ENewsFromJson(Map<String, dynamic> json) => ENews(
      status: json['status'] as String,
      totalResults: (json['totalResults'] as num).toInt(),
      articles: (json['articles'] as List<dynamic>)
          .map((e) => EArticle.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ENewsToJson(ENews instance) => <String, dynamic>{
      'status': instance.status,
      'totalResults': instance.totalResults,
      'articles': instance.articles,
    };
