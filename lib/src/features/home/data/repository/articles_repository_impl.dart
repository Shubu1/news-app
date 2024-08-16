import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_connect/src/config/app_strings.dart';
import 'package:news_connect/src/features/home/domain/model/news_article_model.dart';
import 'package:news_connect/src/features/home/domain/repository/news_articles_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  @override
  Future<List<Articless>?> getArticles() async {
    var response = await http.get(Uri.parse(ApiData.url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      List<Articless>? articles = ApiResultModel.fromJson(data).articles;
      return articles;
    } else {
      throw Exception();
    }
  }
}
