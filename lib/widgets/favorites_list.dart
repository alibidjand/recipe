import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/screens/category_detail_screen.dart';
import 'package:recipe/widgets/custom_scaffold_widget.dart';
import '../providers/favorite_provider_category.dart';
import '../model/data-model.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = context.watch<FavoriteProviderCategory>();
    final List<FoodRecipe> favoriteRecipes =
        favoriteProvider.getFavoriteRecipes();

    return CustomScaffold(
      // appBar: AppBar(
      //   title: const Text("Favorite Recipes"),
      // ),
      body: ListView.builder(
        itemCount: favoriteRecipes.length,
        itemBuilder: (context, index) {
          final recipe = favoriteRecipes[index];
          return RecipeCard(
            recipe: recipe,
            isFavorite: true,
          );
        },
      ),
      title: 'Favourites',
    );
  }
}
