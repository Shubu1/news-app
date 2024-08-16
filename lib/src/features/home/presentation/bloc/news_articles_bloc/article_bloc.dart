/*import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_connect/src/features/home/domain/model/news_article_model.dart';
import 'package:news_connect/src/features/home/domain/repository/news_articles_repository.dart';
import 'package:news_connect/src/features/home/presentation/bloc/news_articles_bloc/article_event.dart';
import 'package:news_connect/src/features/home/presentation/bloc/news_articles_bloc/article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository repository;
  ArticleBloc({required this.repository}) : super(ArticleInitialState()) {
    on<FetchArticleEvent>(_onFetchArticleEvent);
  }

  Future<void> _onFetchArticleEvent(
      FetchArticleEvent event, Emitter<ArticleState> emit) async {
    emit(ArticleLoadingState());
    try {
      List<Articles>? articles = await repository.getArticles();
      emit(ArticleLoadedState(articles: articles));
    } catch (e) {
      emit(ArticleErrorState(message: e.toString()));
    }
  }
}*/
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_connect/src/features/home/domain/model/news_article_model.dart';
import 'package:news_connect/src/features/home/domain/repository/news_articles_repository.dart';
import 'package:news_connect/src/features/home/presentation/bloc/news_articles_bloc/article_event.dart';
import 'package:news_connect/src/features/home/presentation/bloc/news_articles_bloc/article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository repository;
  List<Articless>? _articles = [];

  ArticleBloc({required this.repository}) : super(ArticleInitialState()) {
    on<FetchArticleEvent>(_onFetchArticleEvent);
    on<SearchArticlesEvent>(_onSearchArticlesEvent);
  }

  Future<void> _onFetchArticleEvent(
      FetchArticleEvent event, Emitter<ArticleState> emit) async {
    emit(ArticleLoadingState());
    try {
      _articles = await repository.getArticles();
      emit(ArticleLoadedState(articles: _articles));
    } catch (e) {
      emit(ArticleErrorState(message: e.toString()));
    }
  }

  void _onSearchArticlesEvent(
      SearchArticlesEvent event, Emitter<ArticleState> emit) {
    if (state is ArticleLoadedState) {
      final currentState = state as ArticleLoadedState;
      final query = event.query.toLowerCase();
      final filteredArticles = _articles!.where((article) {
        return article!.title!.toLowerCase().contains(query);
      }).toList();
      emit(ArticleLoadedState(articles: filteredArticles));
    }
  }
}
