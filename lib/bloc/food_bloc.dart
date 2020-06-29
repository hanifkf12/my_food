import 'package:my_food/model/detail_meals.dart';
import 'package:my_food/model/meals.dart';
import 'package:my_food/repository/food_repository.dart';
import 'package:rxdart/rxdart.dart';

class FoodBloc {
  final _repository = FoodRepository();

  BehaviorSubject<Meals> _subject = BehaviorSubject<Meals>();

  BehaviorSubject<Meals> get subject => _subject;

  BehaviorSubject<Meals> _searchSubject = BehaviorSubject<Meals>();

  BehaviorSubject<Meals> get searchSubject => _searchSubject;

  BehaviorSubject<DetailMeal> _detailSubject = BehaviorSubject<DetailMeal>();

  BehaviorSubject<DetailMeal> get detailSubject => _detailSubject;

  fetchFoods(String category) async {
    Meals _meals = await _repository.fetchFoods(category);
    _subject.sink.add(_meals);
  }

  searchFoods(String param) async{
    Meals _meals = await _repository.searchFoods(param);
    _searchSubject.sink.add(_meals);
  }

  fetchDetailMeal(String strId) async {
    DetailMeal food = await _repository.fetchDetailMeal(strId);
    _detailSubject.sink.add(food);
  }
  drainDetail(){
    _detailSubject.value = null;
    _detailSubject.drain();
  }

  drainSearch(){
    _searchSubject.value = null;
    _searchSubject.drain();
  }

  drainAllMeals(){
    _subject.value = null;
    _detailSubject.drain();
  }

  dispose() {
    _subject.close();
    _detailSubject.close();
    _searchSubject.close();
  }
}

final bloc = FoodBloc();
