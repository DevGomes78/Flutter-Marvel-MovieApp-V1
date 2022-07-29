import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marvel/views/shimer_page.dart';
import 'package:provider/provider.dart';

import '../constants/String_constants.dart';
import '../controller/marvel_controller.dart';
import '../data/models/marvel_models.dart';
import 'details_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final TextEditingController _searchController = TextEditingController();
  late final MarvelController controller;
  bool isLoading = false;
 var lista;

  @override
  void initState() {
    setState(() {
      loadUser();
    });
    controller = context.read<MarvelController>();
    controller.itemsFavorito;
    super.initState();
  }

  Future loadUser() async {
    setState(() => isLoading = true);
    await Future.delayed(
      const Duration(seconds: 6),
    );
    setState(() => isLoading = false);
  }

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
        centerTitle: true,
      ),
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          searchBar(),
          const SizedBox(height: 20),
          Expanded(
              child: GridView.builder(
                  gridDelegate: const
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 3,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: isLoading ? 2 : controller.ItemsFavorito.length,
                  itemBuilder: (context, index) {
                    if (isLoading) {
                      return const Skeleton().buildListView();
                    } else {
                      controller.ItemsFavorito.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : lista =controller.ItemsFavorito[index];

                      return marvelList(context, lista);
                    }
                  })),
        ],
      ),
    ));
  }

  InkWell marvelList(BuildContext context, Data lista) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsPage(
                      data: lista,
                    )));
      },

         child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 5,
              ),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  color: Colors.black54,
                ),
                child: Image(
                  image: CachedNetworkImageProvider(
                    lista.coverUrl.toString(),
                    maxHeight: 200,
                    maxWidth: 200,
                  ),
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) {
                      return child;
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                    );
                  },
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),


    );
  }

  TextField searchBar() {
    return TextField(
      onChanged: search,
      decoration: InputDecoration(
          hintText: StringConstants.searchMovies,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          prefixIcon: IconButton(
            onPressed: () {
              controller.getData(query: _searchController.text);
            },
            icon: const Icon(Icons.search),
          )),
      controller: _searchController,
    );
  }

  String? search(String query) {
    if (_searchController.text.isEmpty) {
      setState(() {
        controller.getData(query: '');
      });
    } else {
      controller.getData(query: _searchController.text);
    }
    return null;
  }
}
