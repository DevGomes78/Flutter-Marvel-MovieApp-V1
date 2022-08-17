import 'package:flutter/material.dart';

import '../constants/image_constants.dart';
class StarList extends StatelessWidget {
  const StarList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Column(
            children:  [
              const CircleAvatar(
                backgroundImage: AssetImage(ImageConstants.imageAssetcrisEvans),
                radius: 35,
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.topCenter,
                height: 50,
                width: 50,
                child: const Text(
                  'Chris Evans',
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            children:  [
              const CircleAvatar(
                backgroundImage: AssetImage(ImageConstants.imageAssetscarlet),
                radius: 35,
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.topCenter,
                height: 50,
                width: 60,
                child: const Text(
                  'Scarlett Johansson',
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            children:  [
              const CircleAvatar(
                backgroundImage: AssetImage('images/Cris hemsworthr.jpg'),
                radius: 35,
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.topCenter,
                height: 50,
                width: 50,
                child: const Text(
                  'Chris Hemsworth ',
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            children:  [
              const CircleAvatar(
                backgroundImage: AssetImage('images/robert downey jr.jpg'),
                radius: 35,
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.topCenter,
                height: 50,
                width: 70,
                child: const Text(
                  '  Robert Downey Jr',
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            children:  [
              const CircleAvatar(
                backgroundImage: AssetImage('images/mark huffalo.jpg'),
                radius: 35,
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.topCenter,
                height: 50,
                width: 50,
                child: const Text(
                  'Mark Ruffalo',
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            children:  [
              const CircleAvatar(
                backgroundImage: AssetImage('images/Samuel ljackson.jpg'),
                radius: 35,
              ),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.topCenter,
                height: 50,
                width: 50,
                child: const Text(
                  'Samuel Ljackson',
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}