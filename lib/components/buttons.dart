import 'package:flutter/material.dart';

class BuildButton extends StatefulWidget {
  const BuildButton({Key? key}) : super(key: key);

  @override
  State<BuildButton> createState() => _BuildButtonState();
}

class _BuildButtonState extends State<BuildButton> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5,
            ),
            child: Chip(
              elevation: 5,
              label: Text(
                'Todos',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black38,
              padding: EdgeInsets.only(left: 12, right: 12),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5,
            ),
            child: Chip(
              elevation: 5,
              label: Text(
                'Homen aranha',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black38,
              padding: EdgeInsets.only(left: 12, right: 12),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5,
            ),
            child: Chip(
              elevation: 5,
              label: Text(
                'Hulk',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black38,
              padding: EdgeInsets.only(left: 12, right: 12),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5,
            ),
            child: Chip(
              elevation: 5,
              label: Text(
                'Ironman',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black38,
              padding: EdgeInsets.only(left: 12, right: 12),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5,
            ),
            child: Chip(
              elevation: 5,
              label: Text(
                'Capitao america',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black38,
              padding: EdgeInsets.only(left: 12, right: 12),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5,
            ),
            child: Chip(
              elevation: 5,
              label: Text(
                'Guardioes da galaxia',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black38,
              padding: EdgeInsets.only(left: 10, right: 10),
            ),
          ),
        ],
      ),
    );
  }
}