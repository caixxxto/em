import 'package:emehanika_tech/src/app/models/e_source/e_source.dart';
import 'package:emehanika_tech/src/app/ui_kit/theme/text_style.dart';
import 'package:emehanika_tech/src/modules/news/controllers/all_news_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NewsCardWidget extends StatelessWidget {
  final BuildContext context;
  final String title;
  final String subtitle;
  final String image;
  final String date;
  final String text;
  final Source source;
  final bool isFav;

  const NewsCardWidget({
    super.key,
    required this.context,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.date,
    required this.text,
    required this.source,
    required this.isFav,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/news_card', extra: {
          'title': title,
          'subtitle': subtitle,
          'image': image,
          'date': date,
          'text': text,
          'source': source,
          'isFav': isFav,
          'controller': context.read<NewsController>(),
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xffCECECE),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: const Offset(0, 3),
              blurRadius: 6.1,
            ),
          ],
        ),
        height: 112,
        child: Row(
          children: [
            Container(
              height: 112,
              width: 123,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                color: Colors.grey,
              ),
              child: image.isNotEmpty
                  ? ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey,
                            child: const Icon(Icons.error),
                          );
                        },
                      ),
                    )
                  : Container(
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
                      ),
                      child: const Icon(Icons.article),
                    ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: ETextStyle.satoshiRegular
                          .copyWith(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: ETextStyle.satoshiRegular.copyWith(fontSize: 19),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          date,
                          style:
                              ETextStyle.satoshiRegular.copyWith(fontSize: 17),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
