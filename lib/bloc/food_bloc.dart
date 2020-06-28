import 'package:my_food/model/detail_meals.dart';
import 'package:my_food/model/meals.dart';
import 'package:my_food/repository/food_repository.dart';
import 'package:rxdart/rxdart.dart';

class FoodBloc {
  final _repository = FoodRepository();

  BehaviorSubject<Meals> _subject = BehaviorSubject<Meals>();

  BehaviorSubject<Meals> get subject => _subject;

  BehaviorSubject<DetailMeal> _detailSubject = BehaviorSubject<DetailMeal>();

  BehaviorSubject<DetailMeal> get detailSubject => _detailSubject;

  fetchFoods(String category) async {
    Meals _meals = await _repository.fetchFoods(category);
    _subject.sink.add(_meals);
  }

  fetchDetailMeal(String strId) async {
    DetailMeal food = await _repository.fetchDetailMeal(strId);
    _detailSubject.sink.add(food);
  }

  dispose() {
    _subject.close();
    _detailSubject.close();
  }
}

final bloc = FoodBloc();
