import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marvel/data/models/marvel_models.dart';
import 'package:marvel/views/details_page.dart';
import 'package:marvel/views/shimer_page.dart';
import 'package:provider/provider.dart';
import '../components/text_style.dart';
import '../constants/string_constants.dart';
import '../controller/marvel_controller.dart';

class MarvelListPage extends StatefulWidget {
  const MarvelListPage({Key? key}) : super(key: key);

  @override
  State<MarvelListPage> createState() => _MarvelListPageState();
}

class _MarvelListPageState extends State<MarvelListPage> {
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
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 80),
          Text(
            StringConstants.titleText,
            style: AppTextStyle.font28Bold,
          ),
          const SizedBox(height: 20),
          SearchBar(),
          Expanded(
              child: ListView.builder(
                  itemCount: isLoading ? 2 : provider.lista.length,
                  itemBuilder: (context, index) {
                    if (isLoading) {
                      return Skeleton().buildListView();
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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailsPage(data: lista)));
      },
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  color: Colors.black54,
                ),
                child: Image(
                  image: CachedNetworkImageProvider(
                    lista.coverUrl.toString(),
                    maxHeight: 200,
                    maxWidth: 150,
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
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    lista.title.toString(),
                    style: AppTextStyle.font26,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextField SearchBar() {
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
