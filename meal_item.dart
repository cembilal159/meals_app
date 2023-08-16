import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../models/meal.dart';
import './meal_item_trait.dart';

class MealItem extends StatelessWidget {
  MealItem({super.key, required this.meal, required this.onSelectMeal});
  final Meal meal;
  void Function(Meal meal) onSelectMeal;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      elevation: 2,
      clipBehavior:
          Clip.hardEdge, //LETS THE WIDGET BELOW TO GET AFFECTED BY RADIOUS
      child: InkWell(
        onTap: () {
          onSelectMeal(meal);
        },
        child: Stack(
          children: [
            Hero(
              tag: meal.id ,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover, //FOR FITTING IMAGE INTO THE BOX
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                            icon: Icons.schedule, label: "${meal.duration}min"),
                        SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(icon: Icons.work, label: complexityText),
                        SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(
                            icon: Icons.attach_money, label: affordabilityText)
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}