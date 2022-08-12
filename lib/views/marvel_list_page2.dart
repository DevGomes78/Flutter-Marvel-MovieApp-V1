import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/text_style.dart';
import '../constants/service_constants.dart';
import '../constants/string_constants.dart';
import '../controller/marvel_controller.dart';
import '../controller/search_movie.dart';
import '../data/models/marvel_models.dart';
import '../utils/routes.dart';
import 'details_page.dart';

class MarvelListPage2 extends StatefulWidget {
  const MarvelListPage2({Key? key}) : super(key: key);

  @override
  State<MarvelListPage2> createState() => _MarvelListPage2State();
}

class _MarvelListPage2State extends State<MarvelListPage2> {
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
    return LayoutBuilder(builder: (context, constrains) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            StringConstants.titleText,
            style: AppTextStyle.font22Bold,
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
                const SizedBox(height: 20),
                carrouselSlider(provider),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    StringConstants.assistaAgora,
                    style: AppTextStyle.font22,
                  ),
                ),
                const SizedBox(height: 10),
                listMovie(provider),
                const SizedBox(height: 20),
                Text('Atores principais ', style: AppTextStyle.font22),
                const SizedBox(height: 15),
                starsList(),
              ],
            ),
          ),
        ),
      );
    });
  }

  Container starsList() {
    return Container(
      height: 150,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Column(
            children: const [
              CircleAvatar(
                backgroundImage: AssetImage('images/crisevans.jpg'),
                radius: 40,
              ),
              SizedBox(height: 10),
              Text('Cris'),
              Text('Evans'),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            children: const [
              CircleAvatar(
                backgroundImage: AssetImage('images/scarlet.jpg'),
                radius: 40,
              ),
              SizedBox(height: 10),
              Text('Scaret'),
              Text('Jahansen'),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            children: const [
              CircleAvatar(
                backgroundImage: AssetImage('images/crishenswolf.jpg'),
                radius: 40,
              ),
              SizedBox(height: 10),
              Text(
                'Chris',
              ),
              Text('Hemsworth'),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            children: const [
              CircleAvatar(
                backgroundImage: AssetImage('images/Robert_Downeyjpg.jpg'),
                radius: 40,
              ),
              SizedBox(height: 10),
              Text('Robert '),
              Text(' Downey Jr.'),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            children: const [
              CircleAvatar(
                backgroundImage: AssetImage('images/rufallo.jpg'),
                radius: 40,
              ),
              SizedBox(height: 10),
              Text('Mark '),
              Text('Rufallo.'),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            children: const [
              CircleAvatar(
                backgroundImage: AssetImage('images/samueljpg.jpg'),
                radius: 40,
              ),
              SizedBox(height: 10),
              Text('Samuel '),
              Text('L Jackson'),
            ],
          ),
        ],
      ),
    );
  }

  Container listMovie(MarvelController provider) {
    return Container(
      height: 240,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: provider.lista.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 200,
                  width: 210,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                    data: provider.lista[index],
                                  )));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image: CachedNetworkImageProvider(
                          provider.lista[index].coverUrl.toString(),
                          maxHeight: 260,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    provider.lista[index].title.toString(),
                    style: AppTextStyle.font12Bold,
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        alignment: Alignment.center,
                        height: 25,
                        width: 50,
                        child: Image.asset(ServiceConstants.imageAsset),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text('8.4', style: AppTextStyle.font15),
                  ],
                ),
              ],
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
          initialPage: 2,
          height: 250,
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
