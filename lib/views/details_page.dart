import 'package:flutter/material.dart';
import 'package:marvel/constants/string_constants.dart';
import '../data/models/marvel_models.dart';
import 'package:url_launcher/url_launcher.dart';

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Stack(
                children: [
                  Container(
                    height: 350,
                    width: double.infinity,
                    child: Image.network(
                      widget.data!.coverUrl.toString(),
                      fit: BoxFit.fill,
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
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Sumary ',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(widget.data!.overview.toString()),
              const SizedBox(height: 20),
              Container(
               // alignment: Alignment.center,
                height: 20,
                width: double.infinity,
                child: Row(
                  children: [
                    Text('Rating :'),SizedBox(width: 20),
                    Image.asset('images/5stars.png'),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Text(StringConstants.duration),
                  Text(
                    widget.data!.duration.toString(),
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text(StringConstants.minutes),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Text(StringConstants.directed),
                  Text(widget.data!.directedBy.toString()),
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
