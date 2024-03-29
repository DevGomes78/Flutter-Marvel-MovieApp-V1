import 'package:flutter/material.dart';
import 'package:marvel/constants/string_constants.dart';
import 'package:marvel/service/marvelapi_service.dart';
import 'package:marvel/views/details_page.dart';
import '../data/models/marvel_models.dart';

class SearchMovie extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Data>?>(
        future: MarvelController().getData(query: query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var lista = snapshot.data![index];
                  return Card(
                    elevation: 2,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          lista.coverUrl.toString(),
                        ),
                      ),
                      title: Text(
                        lista.title.toString(),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                      data: lista,
                                    )));
                      },
                    ),
                  );
                });
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text(
        StringConstants.searchMovies,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
