import 'package:hive/hive.dart';
import 'package:news_connect/src/features/home/domain/model/news_article_model.dart';

part 'articles.g.dart';

@HiveType(typeId: 0)
class Articles extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String publishedAt;

  @HiveField(2)
  final String urlToImage;

  Articles(
      {required this.title,
      required this.publishedAt,
      required this.urlToImage});

  Articless toDomainModel() {
    return Articless(
      title: title,
      publishedAt: publishedAt,
      urlToImage: urlToImage,
    );
  }
}
