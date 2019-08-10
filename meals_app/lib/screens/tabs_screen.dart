import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/favorites_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> availableMeals;
  final List<String> favoriteMealIds;

  const TabsScreen(this.availableMeals, this.favoriteMealIds);

  @override
  State<StatefulWidget> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabsScreen> {
  List<Widget> _pages;

  int _selectedPageNumber = 0;

  @override
  void initState() {
    _pages = [
      CategoriesScreen(),
      FavoritesScreen(widget.availableMeals, widget.favoriteMealIds)
    ];

    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageNumber = index;
    });
  }

  get pageName {
    if (_selectedPageNumber == 0) {
      return "Meal categories";
    } else {
      return "Favorite meals";
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: MainDrawer(),
        ),
        appBar: AppBar(
          title: Text(
            pageName,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white30,
          currentIndex: _selectedPageNumber,
          items: [
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.category),
                title: Text('Categories')),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.star),
                title: Text('Favorites')),
          ],
        ),
        body: _pages[_selectedPageNumber],
      ),
    );
//    return DefaultTabController(
//      length: 2,
//      child: Scaffold(
//        appBar: AppBar(
//          title: Text(
//            'Meals',
//          ),
//          bottom: TabBar(
//            tabs: <Widget>[
//              Tab(
//                icon: Icon(Icons.category),
//                text: "Categories",
//              ),
//              Tab(
//                icon: Icon(Icons.star),
//                text: "Favorites",
//              )
//            ],
//          ),
//        ),
//        body: TabBarView(
//          children: <Widget>[CategoriesScreen(), FavoritesScreen()],
//        ),
//      ),
//    );
  }
}
