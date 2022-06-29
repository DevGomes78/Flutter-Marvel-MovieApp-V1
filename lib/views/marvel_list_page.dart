import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/marvel_controller.dart';



class MarvelListPage extends StatefulWidget {
  const MarvelListPage({Key? key}) : super(key: key);

  @override
  State<MarvelListPage> createState() => _MarvelListPageState();
}

class _MarvelListPageState extends State<MarvelListPage> {
  late final MarvelController controller;

  @override
  void initState() {
    controller = context.read<MarvelController>();
    controller.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MarvelController provider = Provider.of<MarvelController>(context);
    return Scaffold(
        body: ListView.builder(
            itemCount: provider.lista.length,
            itemBuilder: (context, index) {
              var lista = provider.lista[index];
              return Card(
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
                        decoration: BoxDecoration(
                          color: Colors.black54,
                        ),
                        child: Image.network(
                          lista.coverUrl.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                lista.title.toString(),
                                style: TextStyle(fontSize: 24),
                              ),
                              Text(lista.releaseDate.toString(),
                                style: TextStyle(fontSize: 20),),
                              Text(lista.duration.toString()),
                              Text(lista.directedBy.toString()),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
