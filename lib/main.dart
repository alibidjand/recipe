import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/data/sample-data.dart';
import 'package:recipe/model/data-model.dart';
import 'package:recipe/providers/favorite_provider_category.dart';
import 'package:recipe/screens/category_screen.dart';
import 'package:recipe/screens/recipe-details-page.dart';
import 'package:recipe/widgets/favorites_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteProviderCategory()),
      ],
      child: MaterialApp(
        title: 'Food Recipes App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => CategoryScreen(categories: categories),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/recipe_details') {
            final FoodRecipe recipe = settings.arguments as FoodRecipe;
            return MaterialPageRoute(
              builder: (context) => RecipeDetailsPage(recipe: recipe),
            );
          } else if (settings.name == '/favorites_list') {
            return MaterialPageRoute(
              builder: (context) => const FavoritesList(),
            );
          }
          return null;
        },
      ),
    );
  }
}
