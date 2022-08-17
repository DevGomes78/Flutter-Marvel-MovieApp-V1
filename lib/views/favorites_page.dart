import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/favourites_controller.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Favorites>(context);
    print(provider.listFavorites.length);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,
        title: const Text('Favoritos'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: provider.listFavorites.length,
                  itemBuilder: (context, index) {
                    var lista = provider.listFavorites[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Card(
                        elevation: 5,
                        child: Image.network(lista.coverUrl.toString(),
                        fit: BoxFit.fill,
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
