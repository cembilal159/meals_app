import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/meal.dart';

//STATE NOTIFIER PROVIDER IS USED FOR DYNAMIC DATA STRUCTURES
//IT NEEDS AN EXTRA CLASS WHICH IS 'StateNotifier'

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);
  //here we cannot use add or remove method riverpod package
  //don't allow us to do
  //THAT'S WHY WE TAKE THE PREVIOUS LIST AND RECENTLY CREATED LIST
  //AND COMBINE THEM

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      state = state.where((element) => element.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
  (ref) {
    return FavoriteMealsNotifier();
  },
);
