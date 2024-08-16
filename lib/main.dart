import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:news_connect/firebase_options.dart';
import 'package:news_connect/main_app.dart';
import 'package:news_connect/src/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:news_connect/src/features/home/data/articles/articles.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(ArticlesAdapter());
  await Hive.openBox<Articles>('favoritesBox');
  await Hive.openBox<Articles>('cachedArticlesBox');
  runApp(MainApp(UserRepositoryImpl()));
}
