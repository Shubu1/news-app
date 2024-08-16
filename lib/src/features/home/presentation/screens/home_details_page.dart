import 'package:flutter/material.dart';
import 'package:news_connect/src/common/resources/color_manager.dart';
import 'package:news_connect/src/common/resources/style_manager.dart';
import 'package:news_connect/src/features/home/domain/model/news_article_model.dart';

class HomeDetails extends StatefulWidget {
  final Articless articles;
  const HomeDetails({super.key, required this.articles});

  @override
  State<HomeDetails> createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Expanded(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 18, left: 18, right: 18),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Image(
                        height: 270,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/news_image.jpg')),
                    const SizedBox(height: 30),
                    Text(
                      '${widget.articles.publishedAt}',
                      style: getBoldStyle(
                          color: AppColors.blackPrimary, fontSize: 22),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.articles.author!,
                style: getBoldStyle(
                    color: AppColors.informationBlueGrey, fontSize: 18),
              ),
              const SizedBox(height: 20),
              Text(
                widget.articles.title!,
                style: getBoldStyle(
                    color: AppColors.informationBlueGrey, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
