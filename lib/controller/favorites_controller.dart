import 'dart:convert';

import 'package:flutter/material.dart';

import '../constants/service_constants.dart';
import '../data/models/marvel_models.dart';
import 'package:http/http.dart' as http;

class Favorites extends ChangeNotifier{
  List<String> lista = [];
  bool isFavorite = false;
  
 // lista.add(value)
  
  void favoritosOnly(String value) {
    lista.add(value);
    notifyListeners();
  }
  void toogleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}