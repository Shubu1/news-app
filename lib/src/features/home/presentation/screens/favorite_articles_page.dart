/*import 'package:flutter/material.dart';
import 'package:news_connect/src/common/resources/color_manager.dart';
import 'package:news_connect/src/common/resources/style_manager.dart';
import 'package:news_connect/src/features/home/domain/model/news_article_model.dart';
import 'package:news_connect/src/features/home/presentation/screens/home_details_page.dart';

class FavoritesPage extends StatelessWidget {
  final List<Articless> favoriteArticles;

  const FavoritesPage({super.key, required this.favoriteArticles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favoriteArticles.length,
        itemBuilder: (context, index) {
          final article = favoriteArticles[index];
          return ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: article.urlToImage != null
                  ? Image.network(
                      article.urlToImage!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/news_image.jpg',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
            ),
            title: Text(
              article.title!,
              style: getBoldStyle(
                  color: AppColors.blackPrimaryMinus2, fontSize: 15),
            ),
            subtitle: Text(
              article.publishedAt!,
              style: getBoldStyle(
                  color: AppColors.informationBlueGrey, fontSize: 14),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeDetails(articles: article),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_connect/src/common/resources/color_manager.dart';
import 'package:news_connect/src/common/resources/style_manager.dart';
import 'package:news_connect/src/common/resources/value_manager.dart';
import 'package:news_connect/src/features/home/data/articles/articles.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late Box<Articles> favoritesBox;

  @override
  void initState() {
    super.initState();
    favoritesBox = Hive.box<Articles>('favoritesBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: favoritesBox.listenable(),
        builder: (context, Box<Articles> box, _) {
          final favoriteArticles = box.values.toList();

          if (favoriteArticles.isEmpty) {
            return const Center(
              child: Text('No favorites added yet'),
            );
          }

          return ListView.builder(
            itemCount: favoriteArticles.length,
            itemBuilder: (context, index) {
              final article = favoriteArticles[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p18,
                  vertical: AppPadding.p12 / 2,
                ),
                child: SizedBox(
                  height: 210,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/images/news_image.jpg',
                              height: 140,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        article.title!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: getBoldStyle(
                          color: AppColors.blackPrimaryMinus2,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Expanded(
                        child: Text(
                          article.publishedAt!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: getBoldStyle(
                            color: AppColors.informationBlueGrey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
