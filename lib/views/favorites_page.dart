import 'package:flutter/material.dart';
import 'package:marvel/controller/favorites_controller.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  @override
  Widget build(BuildContext context) {
    Favorites provider = Provider.of<Favorites>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
     body:  ListView.builder(
       itemCount: provider.lista.length,
         itemBuilder: (context,index){
        var lista = provider.lista[index];
         return ListTile(
           title:  Text(lista.toString()),
         );
         }),
    );
  }
}
