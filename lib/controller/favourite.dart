import 'package:flutter/material.dart';
import 'package:marvel/data/models/marvel_models.dart';

class Favorites extends ChangeNotifier{
  late MarvelModels _favoriteList;

  final List<String> _itemsTitle = [];

  MarvelModels get  favoriteList => _favoriteList;

  set favoriteList(MarvelModels newList){
    _favoriteList = newList;
    notifyListeners();
  }

  List get data=> _itemsTitle.map((e) => _favoriteList.data!).toList();
 void add(Data data){
    _itemsTitle.add(data.title.toString());
 }
 }