import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/text_style.dart';
import '../constants/string_constants.dart';
import '../controller/marvel_controller.dart';
import '../controller/search_movie.dart';
import '../utils/routes.dart';
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
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          ListTile(
              leading: const Icon(Icons.star),
              title: const Text(StringConstants.favorites),
              subtitle: const Text(StringConstants.Myfavorites),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushNamed(context, Routes.favorites);
              })
        ],
      )),
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
              carrouselSlider(provider),
              const SizedBox(height: 20),
              Text(
                StringConstants.campeoesDeBilheteria,
                style: AppTextStyle.font22Bold,
              ),
              const SizedBox(height: 20),
              listMovie(provider)
            ],
          ),
        ),
      ),
    );
  }

  Container listMovie(MarvelController provider) {
    return Container(
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
                  child: Image(
                    image: CachedNetworkImageProvider(
                      provider.lista[index].coverUrl.toString(),
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
            );
          }),
    );
  }

  Container carrouselSlider(MarvelController provider) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: CarouselSlider.builder(
        itemCount: provider.lista.length,
        options: CarouselOptions(
          enlargeCenterPage: true,
          height: 320,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          reverse: false,
          aspectRatio: 5.0,
        ),
        itemBuilder: (context, index, id) {
          return (index <= 0)
              ? Container()
              : GestureDetector(
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
                        provider.lista[index].coverUrl.toString(),
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
                                  data: provider.lista[index],
                                )));
                  },
                );
        },
      ),
    );
  }
}
