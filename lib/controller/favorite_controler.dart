
import 'package:flutter/material.dart';

class Favorites extends ChangeNotifier{
  List<String> lista = [];


  int? id;
  String? title;
  String? releaseDate;
  String? boxOffice;
  int? duration;
  String? overview;
  String? coverUrl;
  String? trailerUrl;
  String? directedBy;
  int? phase;
  String? saga;
  int? chronology;
  int? postCreditScenes;
  String? imdbId;
  bool isFavorite = false;

  Favorites({
  this.id,
  this.title,
  this.releaseDate,
  this.boxOffice,
  this.duration,
  this.overview,
  this.coverUrl,
  this.trailerUrl,
  this.directedBy,
  this.phase,
  this.saga,
  this.chronology,
  this.postCreditScenes,
  this.imdbId,
  this.isFavorite = false,
  });


  void favoritosOnly(String value) {
    lista.add(value);
    notifyListeners();
  }
  void toogleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}