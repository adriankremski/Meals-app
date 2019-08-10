import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {

  void openPage(BuildContext context, String route) {
    Navigator.of(context).pushReplacementNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            height: 120,
            width: double.infinity,
            color: Theme.of(context).accentColor,
            padding: EdgeInsets.all(20),
            child: Text(
              'Cooking up!',
              style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w900),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(
              Icons.restaurant,
              size: 26,
            ),
            title: Text("Meals",
                style: TextStyle(
                    fontFamily: "RobotoCondensed",
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
            onTap: () {
              openPage(context, '/');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 26,
            ),
            title: Text("Settings",
                style: TextStyle(
                    fontFamily: "RobotoCondensed",
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
            onTap: () {
              openPage(context, FiltersScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}
