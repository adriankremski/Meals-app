import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/dummy-data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal_detail_screen';

  final Function toggleFavorite;
  final Function isFavorite;

  const MealDetailScreen(this.toggleFavorite, this.isFavorite);

  Widget buildSectionTitle(BuildContext context, String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget buildContainer(BuildContext context, Widget child) {
    return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(color: Colors.grey)),
        height: 200,
        width: 300,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final mealId = (ModalRoute.of(context).settings.arguments
        as Map<String, String>)['id'];
    final meal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              meal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          buildSectionTitle(context, "Ingredients"),
          buildContainer(
              context,
              ListView.builder(
                itemBuilder: (context, position) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Text(meal.ingredients[position])),
                ),
                itemCount: meal.ingredients.length,
              )),
          buildSectionTitle(context, "Steps"),
          buildContainer(
              context,
              ListView.builder(
                itemBuilder: (context, position) => Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        child: Text("#${position + 1}"),
                      ),
                      title: Text(meal.steps[position]),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    )
                  ],
                ),
                itemCount: meal.steps.length,
              ))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isFavorite(mealId ) ? Icons.star : Icons.star_border) ,
        onPressed: () {
          toggleFavorite(mealId);
        },
      ),
    );
  }
}
