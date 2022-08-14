import 'package:flutter/material.dart';
import 'package:marvel/components/text_style.dart';
import 'package:provider/provider.dart';

import '../controller/favorite_controler.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Favorites>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus favoritos', style: AppTextStyle.font28),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Card(
                  elevation: 5,
                  child: Container(height: 250,
                    width: double.infinity,
                    child: Image.asset('images/banner.jpg',
                    fit: BoxFit.fill,

                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
              Text('Meus favoritos', style: AppTextStyle.font25Bold),
              SizedBox(height: 20),
              Container(
                height: 250,
                width: double.infinity,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.listFavorites.length,
                    itemBuilder: (context, index) {
                      var lista = provider.listFavorites[index];
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Card(
                          elevation: 5,
                          child: Image.network(
                            lista.coverUrl.toString(),
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
