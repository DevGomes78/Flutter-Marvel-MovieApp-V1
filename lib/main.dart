import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marvel/utils/routes.dart';
import 'package:marvel/views/favorites_page.dart';
import 'package:marvel/views/home_page.dart';
import 'package:marvel/views/marvel_list_page.dart';
import 'service/marvelapi_service.dart';
import 'data/models/marvel_models.dart';
import 'package:provider/provider.dart';
import 'controller/favorite_controler.dart';


void main() {
 runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MarvelController()),
        ChangeNotifierProvider(create: (context) => Data()),
        ChangeNotifierProvider(create: (context) => Favorites()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        routes: {
          Routes.HOME: (context) => const HomePage(),
          Routes.marvelListPage: (context) => const MarvelListPage(),
          Routes.favorites: (context) => const FavoritesPage(),
        },
      ),
    );
  }
}
