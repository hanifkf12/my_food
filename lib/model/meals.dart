// To parse this JSON data, do
//
//     final meals = mealsFromJson(jsonString);

import 'dart:convert';

Meals mealsFromJson(String str) => Meals.fromJson(json.decode(str));

String mealsToJson(Meals data) => json.encode(data.toJson());

class Meals {
  Meals({
    this.meals,
  });

  List<Meal> meals;

  factory Meals.fromJson(Map<String, dynamic> json) => Meals(
    meals: json["meals"] == null ? null : List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meals": meals == null ? null : List<dynamic>.from(meals.map((x) => x.toJson())),
  };
}

class Meal {
  Meal({
    this.strMeal,
    this.strMealThumb,
    this.idMeal,
  });

  String strMeal;
  String strMealThumb;
  String idMeal;

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
    strMeal: json["strMeal"] == null ? null : json["strMeal"],
    strMealThumb: json["strMealThumb"] == null ? null : json["strMealThumb"],
    idMeal: json["idMeal"] == null ? null : json["idMeal"],
  );

  Map<String, dynamic> toJson() => {
    "strMeal": strMeal == null ? null : strMeal,
    "strMealThumb": strMealThumb == null ? null : strMealThumb,
    "idMeal": idMeal == null ? null : idMeal,
  };
}
