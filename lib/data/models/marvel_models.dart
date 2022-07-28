import 'package:flutter/material.dart';

class MarvelModels  extends ChangeNotifier {
  List<Data>? data;
  int? total;
 late bool isFavorite;
 int? id;

  MarvelModels({this.data, this.total, this.id, required this.isFavorite});

  MarvelModels.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    total = json['total'];


  }
  toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}

class Data{
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

  Data(
      {this.id,
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

      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    releaseDate = json['release_date'];
    boxOffice = json['box_office'];
    duration = json['duration'];
    overview = json['overview'];
    coverUrl = json['cover_url'];
    trailerUrl = json['trailer_url'];
    directedBy = json['directed_by'];
    phase = json['phase'];
    saga = json['saga'];
    chronology = json['chronology'];
    postCreditScenes = json['post_credit_scenes'];
    imdbId = json['imdb_id'];
  }


}
