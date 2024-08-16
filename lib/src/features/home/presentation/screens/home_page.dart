/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_connect/src/common/resources/color_manager.dart';
import 'package:news_connect/src/common/resources/style_manager.dart';
import 'package:news_connect/src/features/home/presentation/bloc/news_articles_bloc/article_bloc.dart';
import 'package:news_connect/src/features/home/presentation/bloc/news_articles_bloc/article_event.dart';
import 'package:news_connect/src/features/home/presentation/bloc/news_articles_bloc/article_state.dart';
import 'package:news_connect/src/features/home/presentation/screens/widgets/home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ArticleBloc? articleBloc;
  @override
  void initState() {
    super.initState();
    articleBloc = BlocProvider.of<ArticleBloc>(context);
    articleBloc!.add(FetchArticleEvent());
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.greenWithOpacity40,
      ),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: getBoldStyle(color: Colors.red),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<ArticleBloc, ArticleState>(
      listener: (context, state) {
        if (state is ArticleErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message ?? "Error loading data"),
            ),
          );
        }
      },
      child: BlocBuilder<ArticleBloc, ArticleState>(
        builder: (context, state) {
          if (state is ArticleInitialState) {
            return buildLoading();
          } else if (state is ArticleLoadingState) {
            return buildLoading();
          } else if (state is ArticleLoadedState) {
            return HomeWidget(
              articles: state.articles!,
            );
          } else if (state is ArticleErrorState) {
            return buildErrorUi(state.message ?? "Error loading data");
          }
          return buildErrorUi("Error loading data");
        },
      ),
    ));
  }
}
*/
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_connect/src/common/resources/color_manager.dart';
import 'package:news_connect/src/common/resources/style_manager.dart';
import 'package:news_connect/src/features/home/presentation/bloc/news_articles_bloc/article_bloc.dart';
import 'package:news_connect/src/features/home/presentation/bloc/news_articles_bloc/article_event.dart';
import 'package:news_connect/src/features/home/presentation/bloc/news_articles_bloc/article_state.dart';
import 'package:news_connect/src/features/home/presentation/screens/widgets/home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ArticleBloc articleBloc;
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    articleBloc = BlocProvider.of<ArticleBloc>(context);
    articleBloc.add(FetchArticleEvent());

    // Add a listener to handle search input changes
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      print('Search query: ${_searchController.text}');
      articleBloc.add(SearchArticlesEvent(query: _searchController.text));
    });
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.greenWithOpacity40,
      ),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: getBoldStyle(color: Colors.red),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search articles...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.green),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          ),
        ),
      ),
      body: BlocListener<ArticleBloc, ArticleState>(
        listener: (context, state) {
          if (state is ArticleErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message ?? "Error loading data"),
              ),
            );
          }
        },
        child: BlocBuilder<ArticleBloc, ArticleState>(
          builder: (context, state) {
            if (state is ArticleInitialState) {
              return buildLoading();
            } else if (state is ArticleLoadingState) {
              return buildLoading();
            } else if (state is ArticleLoadedState) {
              return HomeWidget(
                articles: state.articles!,
              );
            } else if (state is ArticleErrorState) {
              return buildErrorUi(state.message ?? "Error loading data");
            }
            return buildErrorUi("Error loading data");
          },
        ),
      ),
    );
  }
}
