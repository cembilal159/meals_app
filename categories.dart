import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import '../data/dummy_data.dart';
import '../models/meal.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
//late allow animationcontroller not to be initialized right away

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        lowerBound: 0,
        upperBound: 1);

    _animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
    //DISPOSE MAKES THE FUNCTION TO BE DELETED FROM DEVICE MEMORY AFTER IT IS INITIATED
    //SO THAT IT DOES NOT VIOLATE ANY SPACES IN THE MEMORY
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where(
          (meal) => meal.categories.contains(category.id),
        )
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            MealsScreen(meals: filteredMeals, title: category.title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: [
          // availableCategories.map((e) => CategoryGrid(category: category)).toList(),
          for (final category in availableCategories)
            CategoryGrid(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            )
        ],
      ),
      builder: (context, child) => SlideTransition(
        position:
            Tween(begin: const Offset(0, 0.3), end: const Offset(0, 0)).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.decelerate),
        ),
      child: child
      ),
    )
        //Padding(padding: EdgeInsets.only(top:100-_animationController.value *100),child: child) ,
        );
  }
}
