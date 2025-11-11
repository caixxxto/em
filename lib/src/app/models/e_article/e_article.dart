import 'package:emehanika_tech/src/app/models/e_source/e_source.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'e_article.g.dart';

@JsonSerializable()
class EArticle extends Equatable{
  final Source source;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final String? content;
  final bool? isFavorite;

  const EArticle({
    required this.source,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
    this.isFavorite,
  });

  EArticle copyWith({
    bool? isFavorite,
  }) =>
      EArticle(
        isFavorite: isFavorite ?? this.isFavorite,
        source: source,
        author: author,
        title: title,
        description: description,
        url: url,
        urlToImage: urlToImage,
        publishedAt: publishedAt,
        content: content,
      );

  @override
  List<Object?> get props => [
        source,
        author,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content,
        isFavorite,
      ];

  factory EArticle.fromJson(Map<String, dynamic> json) =>
      _$EArticleFromJson(json);

  Map<String, dynamic> toJson() => _$EArticleToJson(this);
}
