
import 'package:flutter/material.dart';

class Favorites extends ChangeNotifier{
  List<String> lista = [];
  bool isFavorite = false;

  void favoritosOnly(String value) {
    lista.add(value);
    notifyListeners();
  }
  void toogleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}