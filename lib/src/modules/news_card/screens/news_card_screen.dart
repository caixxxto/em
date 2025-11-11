import 'package:emehanika_tech/src/app/models/e_source/e_source.dart';
import 'package:emehanika_tech/src/app/ui_kit/theme/text_style.dart';
import 'package:emehanika_tech/src/modules/news/controllers/all_news_controller.dart';
import 'package:emehanika_tech/src/modules/news/controllers/all_news_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class NewsCardScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final String date;
  final String text;
  final Source source;
  final bool isFav;
  final NewsController controller;

  const NewsCardScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.date,
    required this.text,
    required this.source,
    required this.isFav,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: controller,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: SvgPicture.asset(
              'assets/icons/arrow_back.svg',
              width: 28,
            ),
          ),
          actions: [
            BlocBuilder<NewsController, AllNewsState>(
                builder: (context, state) {
                  final articleName = source.name;
                  final art = state.articles?.firstWhere((name) => name.source.name == articleName);
                  final isF = art?.isFavorite;

                  return Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: IconButton(
                      onPressed: () {
                        context.read<NewsController>().addToFavorite(source.name);
                      },
                      icon: SvgPicture.asset(
                        isF ?? false ? 'assets/icons/star_fav.svg' : 'assets/icons/star.svg',
                        width: 28,
                      ),
                    ),
                  );
                }
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: ETextStyle.satoshiRegular
                      .copyWith(fontSize: 33, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  subtitle,
                  style: ETextStyle.satoshiRegular.copyWith(
                    fontSize: 27,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      source.name,
                      style: ETextStyle.satoshiRegular.copyWith(
                        fontSize: 19,
                      ),
                    ),
                    Text(
                      formatDate(date),
                      style: ETextStyle.satoshiRegular.copyWith(
                        fontSize: 19,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 3),
                        blurRadius: 6.1,
                        color: Colors.black.withOpacity(0.15),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: _buildNewsImage(),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Text(
                  text,
                  style: ETextStyle.satoshiRegular.copyWith(
                    fontSize: 26,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNewsImage() {
    // Если изображение пустое или содержит невалидный URL, показываем заглушку
    if (image.isEmpty || !image.startsWith('http')) {
      return _buildPlaceholder();
    }

    return Image.network(
      image,
      fit: BoxFit.cover,
      width: double.infinity,
      height: 200,
      errorBuilder: (context, error, stackTrace) {
        // Если произошла ошибка загрузки, показываем заглушку
        return _buildPlaceholder();
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          height: 200,
          color: Colors.grey[200],
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.grey[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.article,
            size: 64,
            color: Colors.grey[500],
          ),
          const SizedBox(height: 8),
          Text(
            'Изображение недоступно',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
        ],
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