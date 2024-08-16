import 'package:news_connect/src/features/home/domain/model/news_article_model.dart';

abstract class ArticleRepository {
  Future<List<Articless>?> getArticles();
}
