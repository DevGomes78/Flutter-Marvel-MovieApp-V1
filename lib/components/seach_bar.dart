import 'package:flutter/material.dart';

Widget SearchBar() {
  return Column(
    children: [
      Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color(0xffF6D5D),
            borderRadius: BorderRadius.circular(30)),
        child: Row(
          children: [
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 38.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: ('Procurar Filmes'),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {

              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: Colors.blueGrey,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 18.0),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      )
    ],
  );
}