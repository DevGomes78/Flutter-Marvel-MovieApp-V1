import 'package:flutter/material.dart';
import 'marvel_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MarvelListPage(),
    );
  }
}