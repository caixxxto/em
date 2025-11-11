// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'e_article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EArticle _$EArticleFromJson(Map<String, dynamic> json) => EArticle(
      source: Source.fromJson(json['source'] as Map<String, dynamic>),
      author: json['author'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      url: json['url'] as String,
      urlToImage: json['urlToImage'] as String?,
      publishedAt: json['publishedAt'] as String,
      content: json['content'] as String?,
      isFavorite: json['isFavorite'] as bool?,
    );

Map<String, dynamic> _$EArticleToJson(EArticle instance) => <String, dynamic>{
      'source': instance.source,
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt,
      'content': instance.content,
      'isFavorite': instance.isFavorite,
    };
