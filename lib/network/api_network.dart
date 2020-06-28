import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:my_food/model/detail_meals.dart';
import 'package:my_food/model/meals.dart';

class ApiNetwork {
  Client client = Client();
  static const maiUrl = 'https://www.themealdb.com/api/json/v1/1/';
  static const category = 'categories.php';
  static const byCategory = 'filter.php?c=';
  static const bySearch = 'search.php?s=';
  static const lookUp = 'lookup.php?i=';

  Future<DetailMeal> fetchDetailMeal(String strId) async {
    var response = await client.get(maiUrl + lookUp + strId);
    if (response.statusCode == 200) {
      print(response.body);
      return DetailMeal.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal Ambil Data');
    }
  }


  Future<Meals> fetchFoods(String category) async {
    var response = await client.get(maiUrl + byCategory + category);
    if (response.statusCode == 200) {
      return Meals.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal Ambil Data');
    }
  }
}

final apiNetwork = ApiNetwork();
