import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/category_item.dart';
import 'package:meals_app/dummy-data.dart';
import 'package:meals_app/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {

  final List<Meal> availableMeals;
  final List<String> favoriteMealIds;

  const FavoritesScreen(this.availableMeals, this.favoriteMealIds);

  @override
  Widget build(BuildContext context) {
    if (favoriteMealIds.isEmpty) {
      return Center(
        child: Text("You have no favorites yet - start adding some"),
      );
    } else {
      final favoriteMeals = availableMeals.where((meal) => favoriteMealIds.contains(meal.id)).toList();

      return ListView.builder(
        itemBuilder: (context, position) {
          final meal = favoriteMeals[position];
          return MealItem(
              mealId: meal.id,
              title: meal.title,
              imageUrl: meal.imageUrl,
              duration: meal.duration,
              affordability: meal.affordability,
              complexity: meal.complexity,
          );
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}
