import 'package:flutter/material.dart';
import 'package:marvel/constants/string_constants.dart';
import 'package:provider/provider.dart';
import '../data/models/marvel_models.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class DetailsPage extends StatefulWidget {
  Data? data;

  DetailsPage({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MovieDetails(),
    );
  }

  Padding MovieDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: ChangeNotifierProvider(
            create: (context) => Data(id: widget.data!.id),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Stack(
                  children: [
                    Container(
                      height: 450,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          widget.data!.coverUrl.toString(),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      child: Consumer<Data>(
                        builder: (context, provider, child) => IconButton(
                          onPressed: () {
                            provider.toogleFavorite();
                          },
                          icon:  Icon(
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
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 60),
                   Text(
                     (DateFormat("yyyy").format(
                         DateTime.parse(
                     widget.data!.releaseDate.toString()))),
                     style: const TextStyle(
                       fontSize: 15,
                       color: Colors.grey,
                     ),),
                    const SizedBox(width: 15),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      widget.data!.duration.toString(),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text(StringConstants.minutes,style: const TextStyle(
                      color: Colors.grey,
                    ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 18),
                    const Text(StringConstants.directed,style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),),
                    Text(widget.data!.directedBy.toString(),style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  height: 45,
                  width: double.infinity,
                  child: Image.asset('images/5stars.png'),
                ),
                const Text(
                  'Sumary ',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(widget.data!.overview.toString()),


                const SizedBox(height: 5),
                Row(
                  children: [

                  ],
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: callVideoPlayer,
                  child: const Text(
                    'watch the trailer: ',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
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

  void callVideoPlayer() async {
    final url = widget.data!.trailerUrl.toString();
    if (await launch(url)) {
      await launch(
        url,
        enableJavaScript: true,
        forceWebView: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
