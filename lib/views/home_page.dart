import 'package:flutter/material.dart';
import 'package:marvel/views/marvel_grid_page.dart';

import 'marvel_list_page.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MarvelGridPage(),
    );
  }
}