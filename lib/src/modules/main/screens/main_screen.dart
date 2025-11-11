import 'package:emehanika_tech/src/app/repositories%20/news_repository/news_interface.dart';
import 'package:emehanika_tech/src/modules/news/controllers/all_news_controller.dart';
import 'package:emehanika_tech/src/modules/news/screens/all_news_screen.dart';
import 'package:emehanika_tech/src/modules/news/screens/favorite_news_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainNewsScreen extends StatefulWidget {
  const MainNewsScreen({super.key});

  @override
  State<MainNewsScreen> createState() => _MainNewsScreenState();
}

class _MainNewsScreenState extends State<MainNewsScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsController>(
      create: (context) => NewsController(
        context.read<NewsRepositoryInterface>(),
        context.read<SharedPreferences>(),
      )..init(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          children: const [
            AllNewsScreen(),
            FavoriteNewsScreen(),
          ],
        ),
        bottomNavigationBar: _buildBottomButtons(),
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xffCECECE),
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 3),
            blurRadius: 6.1,
            color: Colors.black.withOpacity(0.15),
          ),
        ],
      ),
      margin: const EdgeInsets.all(19.0),
      height: 84,
      child: Row(
        children: [
          Expanded(
            child: IconButton(
              onPressed: () {
                _pageController.animateToPage(
                  0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              icon: SvgPicture.asset(
                'assets/icons/news.svg',
                width: 28,
                colorFilter: ColorFilter.mode(
                  _currentPage == 0 ? const Color(0xff2F78FF) : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () {
                _pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              icon:SvgPicture.asset(
                'assets/icons/news_fav.svg',
                width: 28,
                colorFilter: ColorFilter.mode(
                  _currentPage == 1 ? const Color(0xff2F78FF) : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
