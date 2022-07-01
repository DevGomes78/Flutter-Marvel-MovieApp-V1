import 'package:flutter/material.dart';
import 'package:marvel/views/details_page.dart';
import 'package:provider/provider.dart';
import '../controller/marvel_controller.dart';



class MarvelListPage extends StatefulWidget {
  @override
  State<MarvelListPage> createState() => _MarvelListPageState();
}

class _MarvelListPageState extends State<MarvelListPage> {
  final TextEditingController _searchController = TextEditingController();
  late final MarvelController controller;

  @override
  void initState() {
    controller = context.read<MarvelController>();
    controller.getData(query: '');
    super.initState();
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
          const Text(
            'Movies',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SearchBar(),
          Expanded(
            child: ListView.builder(
                itemCount: provider.lista.length,
                itemBuilder: (context, index) {
                  var lista = provider.lista[index];
                  return InkWell(
                    onTap: (){
                      Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context)=>DetailsPage(
                              data: lista)));
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
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      lista.releaseDate.toString(),
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      lista.duration.toString(),
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      lista.directedBy.toString(),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    ));
  }

  TextField SearchBar() {
    return TextField(
      onChanged: buscar,
      decoration: InputDecoration(
          hintText: 'Pesquisar Filmes',
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

  String? buscar(String query) {
    if (query.isEmpty) {
      controller.getData(query: '');
    } else {
      controller.getData(query: _searchController.text);
    }
    return null;
  }
}
