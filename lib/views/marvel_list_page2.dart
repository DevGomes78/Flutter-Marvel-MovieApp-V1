import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/text_style.dart';
import '../constants/string_constants.dart';
import '../controller/marvel_controller.dart';
import '../controller/search_movie.dart';
import 'details_page.dart';

class MarvelListPage2 extends StatefulWidget {
  const MarvelListPage2({Key? key}) : super(key: key);

  @override
  State<MarvelListPage2> createState() => _MarvelListPage2State();
}

class _MarvelListPage2State extends State<MarvelListPage2> {
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
          style: AppTextStyle.font26,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchMovie(),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.all(10),
                child: CarouselSlider.builder(
                  itemCount: provider.lista.length,
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    height: 270,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    reverse: false,
                    aspectRatio: 5.0,
                  ),
                  itemBuilder: (context, i, id) {
                    //for onTap to redirect to another screen
                    return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                        //ClipRRect for image border radius
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            provider.lista[i].coverUrl.toString(),
                            width: 400,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                      data: provider.lista[i],
                                    )));
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Campeões de Bilheterias',
                style: AppTextStyle.font22Bold,
              ),
              const SizedBox(height: 20),
              Container(
                height: 210,
                width: double.infinity,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.lista.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsPage(
                                        data: provider.lista[index],
                                      )));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          height: 180,
                          width: 140,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              provider.lista[index].coverUrl.toString(),
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
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
