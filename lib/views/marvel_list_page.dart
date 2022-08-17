import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
              const SizedBox(height: 60),
              Text(
                StringConstants.titleText,
                style: AppTextStyle.font22,
              ),
              const SizedBox(height: 40),
              searchBar(),
              Expanded(
                  child: ListView.builder(
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

      child:   ClipRRect(
        borderRadius: BorderRadius.circular(25),
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: 180,
                    color: Colors.black54,
                    child: Image(
                      image: CachedNetworkImageProvider(
                        lista.coverUrl.toString(),
                        maxHeight: 180,
                        maxWidth: 130,
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
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Column(
                      children: [
                        Text(
                          lista.title.toString(),
                          style: AppTextStyle.font22Bold,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          (DateFormat("yyyy").format(
                              DateTime.parse(
                                  lista.releaseDate.toString()))),
                        ),
                      ],
                    ),
                  ),
                )
              ],
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