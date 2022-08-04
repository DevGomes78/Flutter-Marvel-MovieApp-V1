import 'package:flutter/material.dart';
import 'package:marvel/components/text_style.dart';
import 'package:marvel/constants/string_constants.dart';
import 'package:marvel/controller/favorites_controller.dart';
import 'package:provider/provider.dart';
import '../constants/service_constants.dart';
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
      body: movieDetails(),
    );
  }

  Padding movieDetails() {
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
                      child: Consumer<Favorites>(
                        builder: (context, provider, child) => IconButton(
                          onPressed: () {
                            provider.toogleFavorite();
                            provider.lista.add(widget.data!.title.toString());

                          },
                          icon: Icon(
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
                          DateTime.parse(widget.data!.releaseDate.toString()))),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 15),
                    container(),
                    const SizedBox(width: 15),
                    Text(
                      widget.data!.duration.toString(),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      StringConstants.minutes,
                      style: AppTextStyle.font15,
                    ),
                    const SizedBox(width: 8),
                    container(),
                    const SizedBox(width: 18),
                    Text(
                      StringConstants.directed,
                      style: AppTextStyle.font15,
                    ),
                    Text(
                      widget.data!.directedBy.toString(),
                      style: AppTextStyle.font15,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  height: 45,
                  width: double.infinity,
                  child: Image.asset(ServiceConstants.imageAsset),
                ),
                Text(
                  StringConstants.sumary,
                  style: AppTextStyle.font25Bold,
                ),
                const SizedBox(height: 20),
                Text(widget.data!.overview.toString()),
                const SizedBox(height: 15),
                InkWell(
                  onTap: callVideoPlayer,
                  child: const Text(
                    StringConstants.watchTheTrailer,
                    style: TextStyle(
                      fontSize: 24,
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

  Container container() {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
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
