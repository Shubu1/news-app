import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_connect/src/common/resources/color_manager.dart';
import 'package:news_connect/src/features/home/data/repository/articles_repository_impl.dart';
import 'package:news_connect/src/features/home/presentation/bloc/news_articles_bloc/article_bloc.dart';
import 'package:news_connect/src/features/home/presentation/screens/favorite_articles_page.dart';
import 'package:news_connect/src/features/home/presentation/screens/home_page.dart';
import 'package:news_connect/src/features/profile/presentation/screens/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  List<Widget> pages = [
    BlocProvider(
      create: (BuildContext context) =>
          ArticleBloc(repository: ArticleRepositoryImpl()),
      child: const HomePage(),
    ),
    const ProfilePage(),
    const FavoritePage()
  ];
  int selectedIndex = 0;

  List<Widget> navBarItems = [
    const Icon(Icons.home_rounded, size: 30),
    const Icon(Icons.person, size: 30),
    const Icon(Icons.favorite_border_outlined, size: 30),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    return Scaffold(
        extendBody: true,
        body: pages[selectedIndex],
        bottomNavigationBar: ScrollToHide(
          scrollController: scrollController,
          child: Theme(
            data: Theme.of(context).copyWith(
                iconTheme: IconThemeData(
              color: Colors.black.withOpacity(0.8),
              size: 30,
            )),
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: AppColors.greenWithOpacity40.withOpacity(0.2),
                  offset: const Offset(0, 1),
                  blurRadius: 15.0,
                ),
              ]),
              child: CurvedNavigationBar(
                index: 0,
                items: navBarItems,
                color: AppColors.white,
                buttonBackgroundColor: Colors.white,
                backgroundColor: Colors.transparent,
                onTap: (int index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ));
  }
}

class ScrollToHide extends StatefulWidget {
  final Widget child;
  final ScrollController scrollController;
  final Duration duration;
  const ScrollToHide({
    super.key,
    required this.child,
    required this.scrollController,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  State<ScrollToHide> createState() => _ScrollToHideState();
}

class _ScrollToHideState extends State<ScrollToHide> {
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(listen);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(listen);
    super.dispose();
  }

  void listen() {
    final direction = widget.scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      show();
    } else if (direction == ScrollDirection.reverse) {
      hide();
    }
  }

  void show() {
    if (!isVisible) setState(() => isVisible = true);
  }

  void hide() {
    if (isVisible) setState(() => isVisible = false);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.duration,
      height: isVisible ? 65.h : 0,
      color: Colors.transparent,
      child: Wrap(
        children: [widget.child],
      ),
    );
  }
}
