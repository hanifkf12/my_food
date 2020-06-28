import 'dart:convert';

DetailMeal detailMealFromJson(String str) => DetailMeal.fromJson(json.decode(str));


class DetailMeal {
  DetailMeal({
    this.meals,
  });

  List<Food> meals;

  factory DetailMeal.fromJson(Map<String, dynamic> json) => DetailMeal(
    meals: List<Food>.from(json["meals"].map((x) => Food.fromJson(x))),
  );
}

class Food {
  Food({
    this.strMeal,
    this.strMealThumb,
    this.idMeal,
    this.strArea,
    this.strInstructions,
    this.strTags
  });

  String strMeal;
  String strMealThumb;
  String idMeal;
  String strArea;
  String strInstructions;
  String strTags;

  factory Food.fromJson(Map<String, dynamic> json) => Food(
    strMeal: json["strMeal"],
    strMealThumb: json["strMealThumb"],
    idMeal: json["idMeal"],
    strArea: json['strArea'],
    strInstructions: json['strInstructions'],
    strTags: json['strTags'],
  );

}
