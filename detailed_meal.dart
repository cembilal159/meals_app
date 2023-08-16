import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/main.dart';
import 'package:meals_app/models/meal.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/providers/favorites_provider.dart';

class DetailedMealScreen extends ConsumerWidget {
  DetailedMealScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
          actions: [
            IconButton(
                onPressed: () {
                  final wasAdded = ref
                      .read(favoriteMealsProvider.notifier)
                      .toggleMealFavoriteStatus(meal);
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(wasAdded
                          ? 'Meal added as favories'
                          : 'Meal removed')));
                },
                icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    //transition builder has to return a transition widget
                    transitionBuilder: (child, animation) {
                      //TWEEN GIVES MORE CONTROL BETWEEN THE ITEMS YOU WANT TO SWITCH
                      return RotationTransition(
                          turns: Tween<double>(begin: 0.9, end: 1.0).animate(animation),
                          child: child);
                    },
                    child: Icon(isFavorite ? Icons.star : Icons.star_border,
                        key: ValueKey(isFavorite))))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: meal.id,
                child: Image.network(
                  meal.imageUrl,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 14),
              Text(
                'Ingredients',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(
                height: 14,
              ),
              for (final ingredient in meal.ingredients)
                Text(
                  ingredient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              SizedBox(
                height: 14,
              ),
              for (final steps in meal.steps)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(
                    steps,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                )
            ],
          ),
        ));
  }
}
