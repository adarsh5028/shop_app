
import 'package:advanced_shop_app/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../widgets/app_drawer.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import './cart_screen.dart';

enum FilterOptions {
  Favorites,
  All,
}


class ProductsOverviewScreen extends StatefulWidget {

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    //final productsContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectdValue) {
              setState(() {
                if(selectdValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else{
                  _showOnlyFavorites = false;
                }

              });

            },
            icon: Icon(
              Icons.more_vert,
            ),

            itemBuilder: (_) => [
              PopupMenuItem(child: Text('Only Favorites'),value: FilterOptions.Favorites,
              ),
              PopupMenuItem(child: Text('Show All'),value: FilterOptions.All,
              ),
            ],

          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch as Widget,
              value: cart.itemCount.toString(), color: Colors.blue,
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],


      ),
      drawer: AppDrawer(),
      body:  ProductsGrid(_showOnlyFavorites),
    );
  }
}

