import 'package:emehanika_tech/src/app/models/e_article/e_article.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'e_news.g.dart';

@JsonSerializable()
class ENews extends Equatable{
  final String status;
  final int totalResults;
  final List<EArticle> articles;

  const ENews({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  @override
  List<Object?> get props => [
        status,
        totalResults,
        articles,
      ];

  factory ENews.fromJson(Map<String, dynamic> json) => _$ENewsFromJson(json);

  Map<String, dynamic> toJson() => _$ENewsToJson(this);
}
