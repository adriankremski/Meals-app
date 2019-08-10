import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/widgets/category_item.dart';
import 'package:meals_app/dummy-data.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> filters;

  const FiltersScreen(this.filters, this.saveFilters);

  @override
  State<StatefulWidget> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  Widget _buildSwitchListTile(
      String title, String subtitle, bool currentValue, Function onChanged) {
    return SwitchListTile(
      onChanged: (newValue) {
        setState(() {
          onChanged(newValue);
        });
      },
      title: Text(title),
      subtitle: Text(subtitle),
      value: currentValue,
    );
  }

  @override
  void initState() {
    _glutenFree = widget.filters['gluten'];
    _vegetarian = widget.filters['vegetarian'];
    _vegan = widget.filters['vegan'];
    _lactoseFree = widget.filters['lactose'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final filters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian
              };

              widget.saveFilters(filters);
            },
          )
        ],
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection",
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                    "Gluten-free", "Exclude gluten-free meals", _glutenFree,
                    (newValue) {
                  _glutenFree = newValue;
                }),
                _buildSwitchListTile(
                    "Vegetarian", "Exclude vegetarian meals", _vegetarian,
                    (newValue) {
                  _vegetarian = newValue;
                }),
                _buildSwitchListTile("Vegan", "Exclude vegan meals", _vegan,
                    (newValue) {
                  _vegan = newValue;
                }),
                _buildSwitchListTile(
                    "Lactose-free", "Exclude lactose-free meals", _lactoseFree,
                    (newValue) {
                  _lactoseFree = newValue;
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
