import 'package:my_food/model/detail_meals.dart';
import 'package:my_food/model/meals.dart';
import 'package:my_food/network/api_network.dart';

class FoodRepository {
  ApiNetwork network = ApiNetwork();

  Future<Meals> fetchFoods(String category) => apiNetwork.fetchFoods(category);

  Future<DetailMeal> fetchDetailMeal(String strId) =>
      apiNetwork.fetchDetailMeal(strId);
}
