import 'package:equatable/equatable.dart';

abstract class ArticleEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchArticleEvent extends ArticleEvent {
  @override
  List<Object?> get props => [];
}

class SearchArticlesEvent extends ArticleEvent {
  final String query;

  SearchArticlesEvent({required this.query});

  @override
  List<Object?> get props => [query];
}
