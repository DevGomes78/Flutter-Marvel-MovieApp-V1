import 'package:flutter/material.dart';
import 'package:marvel/views/splash_screen_page.dart';
import 'package:provider/provider.dart';
import 'controller/favourites_controller.dart';
import 'controller/marvel_controller.dart';
import 'data/models/marvel_models.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> MarvelController()),
       ChangeNotifierProvider(create: (context)=> MarvelModels()),
        ChangeNotifierProvider(create: (context)=>Favorites()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
        ),
        home: const Splash(),
      ),
    );
  }
}