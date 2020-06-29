import 'package:my_food/model/detail_meals.dart';
import 'package:my_food/model/meals.dart';
import 'package:my_food/network/api_network.dart';

class FoodRepository {
  ApiNetwork network = ApiNetwork();

  Future<Meals> fetchFoods(String category) => network.fetchFoods(category);

  Future<DetailMeal> fetchDetailMeal(String strId) =>
      network.fetchDetailMeal(strId);

  Future<Meals> searchFoods(String param) => network.searchFoods(param);
}
