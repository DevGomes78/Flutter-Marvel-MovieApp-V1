import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../data/models/marvel_models.dart';

class MarvelController extends ChangeNotifier {
  List<Data> lista = [];
  final String url = 'https://mcuapi.herokuapp.com/api/v1/movies';

  Future<List<Data>> getData() async {
    try {
      final baseUrl = Uri.parse(url);
      final response = await http.get(baseUrl);
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        decodeJson['data'].forEach((item) => lista.add(Data.fromJson(item)));
        notifyListeners();
        return lista;
      }
    } catch (e) {
      print('Erro ao acessar a Pagina: $e');
      return [];
    }
    return [];
  }
}
