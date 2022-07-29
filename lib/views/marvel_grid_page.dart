import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marvel/views/favoritos_page.dart';
import 'package:marvel/views/shimer_page.dart';
import 'package:provider/provider.dart';
import '../components/text_style.dart';
import '../constants/String_constants.dart';
import '../controller/marvel_controller.dart';
import '../data/models/marvel_models.dart';
import 'details_page.dart';

class MarvelGridPage extends StatefulWidget {
  const MarvelGridPage({Key? key}) : super(key: key);

  @override
  State<MarvelGridPage> createState() => _MarvelGridPageState();
}

class _MarvelGridPageState extends State<MarvelGridPage> {
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
    controller.getData(query: '');
    super.initState();
  }

  Future loadUser() async {
    setState(() => isLoading = true);
    await Future.delayed(
      const Duration(seconds: 6),
    );
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    MarvelController provider = Provider.of<MarvelController>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            StringConstants.titleText,
            style: AppTextStyle.font22Bold,
          ),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                ),
                child: Text(
                  'Acesse sua Conta!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Conta'),
              ),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('Favoritos'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FavoritesPage()));
                },
              ),
              const ListTile(
                leading: Icon(Icons.settings),
                title: Text('Configuraçoes'),
              ),
            ],
          ),
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 3,
                        childAspectRatio: 1.1,
                      ),
                      itemCount: isLoading ? 2 : provider.lista.length,
                      itemBuilder: (context, index) {
                        if (isLoading) {
                          return const Skeleton().buildListView();
                        } else {
                          provider.lista.isEmpty
                              ? const Center(child: CircularProgressIndicator())
                              : lista = provider.lista[index];
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
      child: ChangeNotifierProvider(
        create: (context) => Data(id: lista.id),
        child: Stack(
          children: [
            Card(
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
            Positioned(
              right: 5,
              child: Consumer<Data>(
                builder: (context, provider, child) => IconButton(
                  onPressed: () {
                    provider.toogleFavorite();
                  },
                  icon: Icon(
                    provider.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
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
