import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:news_connect/src/common/resources/color_manager.dart';
import 'package:news_connect/src/common/resources/style_manager.dart';
import 'package:news_connect/src/common/resources/value_manager.dart';
import 'package:news_connect/src/features/home/data/articles/articles.dart';
import 'package:news_connect/src/features/home/domain/model/news_article_model.dart';
import 'package:news_connect/src/features/home/presentation/screens/home_details_page.dart';

class HomeWidget extends StatefulWidget {
  final List<Articless> articles;
  const HomeWidget({super.key, required this.articles});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late Box<Articles> favoritesBox;
  late Box<Articles> cachedArticlesBox;
  List<Articless> cachedArticles = [];

  @override
  void initState() {
    super.initState();
    favoritesBox = Hive.box<Articles>('favoritesBox');
    cachedArticlesBox = Hive.box<Articles>('cachedArticlesBox');
    _loadCachedArticles();
    _checkConnectivity();
  }

  void _loadCachedArticles() {
    final cachedList = cachedArticlesBox.values.toList().cast<Articles>();
    setState(() {
      cachedArticles = cachedList.map((e) => e.toDomainModel()).toList();
    });
  }

  void _saveArticlesToCache(List<Articless> articles) async {
    final box = Hive.box<Articles>('cachedArticlesBox');
    await box.clear(); // Clear existing cache
    final hiveArticles = articles.map((e) => e.toHiveModel()).toList();
    await box.addAll(hiveArticles); // Save new articles
  }

  Future<void> _checkConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // Handle offline scenario
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('You are offline. Displaying cached data.')),
      );
    } else {
      // Optionally save articles to cache
      _saveArticlesToCache(widget.articles);
    }
  }

  void _toggleFavorite(Articless article) async {
    Articles hiveArticle = article.toHiveModel();
    final indexToRemove = favoritesBox.values
        .toList()
        .indexWhere((item) => item.title == hiveArticle.title);

    if (indexToRemove != -1) {
      await favoritesBox.deleteAt(indexToRemove);
    } else {
      await favoritesBox.add(hiveArticle);
    }
    setState(() {});
  }

  Widget newsContainer(BuildContext context, int index) {
    Size size = MediaQuery.of(context).size;
    final article = widget.articles[index];

    return ValueListenableBuilder(
      valueListenable: favoritesBox.listenable(),
      builder: (context, Box<Articles> box, _) {
        final isFavorite =
            box.values.any((item) => item.title == article.title);

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeDetails(articles: article)),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p18,
              vertical: AppPadding.p12 / 2,
            ),
            child: SizedBox(
              height: 220,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: article.urlToImage != null
                            ? Image.network(
                                article.urlToImage!,
                                height: 140,
                                width: size.width,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/news_image.jpg',
                                height: 140,
                                width: size.width,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Positioned(
                        left: AppPadding.p12 / 2,
                        top: AppPadding.p12 / 2,
                        child: GestureDetector(
                          onTap: () => _toggleFavorite(article),
                          child: Container(
                            height: 30,
                            width: 60,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                color: isFavorite ? Colors.red : Colors.grey,
                              ),
                            ),
                          ),
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
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: widget.articles.length,
        itemBuilder: (context, index) {
          return newsContainer(context, index);
        },
      ),
    );
  }
}
