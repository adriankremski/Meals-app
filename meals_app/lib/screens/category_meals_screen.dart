import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/dummy-data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class CategoriesMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoriesMealsScreen(this.availableMeals);

  @override
  State<StatefulWidget> createState() {
    return _CategoriesMealsScreenState();
  }
}

class _CategoriesMealsScreenState extends State<CategoriesMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  bool _loadedInitData = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs["title"];

      final categoryId = routeArgs['id'];

      displayedMeals = widget.availableMeals
          .where((meal) => meal.categories.contains(categoryId))
          .toList();
    }

    _loadedInitData = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(
          itemBuilder: (context, position) {
            final meal = displayedMeals[position];
            return MealItem(
              mealId: meal.id,
              title: meal.title,
              imageUrl: meal.imageUrl,
              duration: meal.duration,
              affordability: meal.affordability,
              complexity: meal.complexity
            );
          },
          itemCount: displayedMeals.length,
        ));
  }
}
