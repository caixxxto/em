import 'package:emehanika_tech/core/failure/failure.dart';
import 'package:emehanika_tech/src/app/ui_kit/theme/text_style.dart';
import 'package:emehanika_tech/src/app/ui_kit/widgets/news_card.dart';
import 'package:emehanika_tech/src/modules/news/controllers/all_news_controller.dart';
import 'package:emehanika_tech/src/modules/news/controllers/all_news_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class AllNewsScreen extends StatelessWidget {
  const AllNewsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: SvgPicture.asset(
                      'assets/icons/search.svg',
                      width: 28,
                    ),
                  ),
                  const SizedBox(width: 5),
                  BlocBuilder<NewsController, AllNewsState>(
                      builder: (context, state) {
                    return Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Поиск новостей...',
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Color(0xff2F78FF)),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            suffixIcon: IconButton(
                              icon:
                                  const Icon(Icons.search, color: Colors.grey),
                              onPressed: () {},
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          onChanged: (value) {
                            context.read<NewsController>().getNews(
                                  search: value,
                                  country: state.selectedCountry,
                                  category: state.selectedCategory,
                                );
                          },
                        ),
                      ),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 16),
              BlocBuilder<NewsController, AllNewsState>(
                buildWhen: (previous, current) {
                  return previous.selectedCategory != current.selectedCategory;
                },
                builder: (context, state) {
                  return _buildChipsRow(context, state);
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19.0),
        child: Column(
          children: [
            const SizedBox(height: 22),
            _buildNewsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsList() {
    return Expanded(
      child: BlocBuilder<NewsController, AllNewsState>(
        builder: (context, state) {

          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.failure != null) {
            return _buildErrorWidget(state.failure!, context);
          }

          if (state.articles == null || state.articles!.isEmpty) {
            return const Center(child: Text('Новости не найдены'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.articles!.length,
                  itemBuilder: (context, index) {
                    final article = state.articles![index];
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildErrorWidget(Failure failure, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Ошибка соединения',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red[400],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              failure.message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChipsRow(BuildContext context, AllNewsState state) {
    final categories = Category.values.toList();

    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          // Если selectedCategory null, то All активна по умолчанию
          final isActive =
              state.selectedCategory == _getCategoryDisplayName(category);

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                // Для категории All передаем null или пустую строку
                final categoryName = category == Category.all
                    ? null
                    : _getCategoryDisplayName(category);

                context.read<NewsController>().getNews(category: categoryName);
              },
              child: Container(
                width: 114,
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xff2F78FF)
                      : const Color(0xffC1C1C1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    _getCategoryDisplayName(category),
                    style: ETextStyle.satoshiRegular.copyWith(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _getCategoryDisplayName(Category category) {
    switch (category) {
      case Category.all:
        return 'All';
      case Category.health:
        return 'Health';
      case Category.business:
        return 'Business';
      case Category.entertainment:
        return 'Entertainment';
      case Category.general:
        return 'General';
      case Category.science:
        return 'Science';
      case Category.sports:
        return 'Sports';
      case Category.technology:
        return 'Technology';
    }
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
