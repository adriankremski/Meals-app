import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:meals_app/dummy-data.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';

import 'models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<String> _favoriteMealIds = [];

  void _setFilters(Map<String, bool> filters) {
    setState(() {
      _filters = filters;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && meal.isGlutenFree) {
          return false;
        } else if (_filters['lactose'] && meal.isLactoseFree) {
          return false;
        } else if (_filters['vegan'] && meal.isVegan) {
          return false;
        } else if (_filters['vegetarian'] && meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    setState(() {
      if (_favoriteMealIds.contains(mealId)) {
        _favoriteMealIds.remove(mealId);
      } else {
        _favoriteMealIds.add(mealId);
      }
    });
  }

  bool _isFavorite(String mealId) => _favoriteMealIds.contains(mealId);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.lightBlueAccent,
          canvasColor: Colors.white,
          fontFamily: "Raleway",
          textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              title: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "RobotoCondensed"))),
      routes: {
        '/': (context) => TabsScreen(_availableMeals, _favoriteMealIds),
        CategoriesMealsScreen.routeName: (context) =>
            CategoriesMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(_toggleFavorite, _isFavorite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_filters, _setFilters)
      },
      onUnknownRoute: (settings) {},
    );
  }
}
