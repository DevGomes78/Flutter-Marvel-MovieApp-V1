import 'package:flutter/material.dart';
import 'package:marvel/constants/string_constants.dart';
import '../data/models/marvel_models.dart';

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
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.data!.title.toString()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                height: 350,
                width: double.infinity,
                child: Image.network(
                  widget.data!.coverUrl.toString(),
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 30),
              Text(widget.data!.overview.toString()),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(StringConstants.duration),
                  Text(
                    widget.data!.duration.toString(),
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 8),
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
            ],
          ),
        ),
      ),
    );
  }
}
