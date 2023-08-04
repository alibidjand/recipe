import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/widgets/custom_scaffold_widget.dart';
import '../model/data-model.dart';
import '../providers/favorite_provider_category.dart';

class RecipeDetailsPage extends StatelessWidget {
  final FoodRecipe recipe;

  const RecipeDetailsPage({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = context.watch<FavoriteProviderCategory>();

    return CustomScaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(recipe.image, fit: BoxFit.cover),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  _buildRecipeTitle(context),
                  const Divider(),
                  _buildIngredients(context),
                  const Divider(),
                  _buildCookingSteps(context),
                ],
              ),
            ),
          ),
        ],
      ),
      title: 'recipe',
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (favoriteProvider.isRecipeFavorite(recipe)) {
            favoriteProvider.removeFromFavorites(recipe);
          } else {
            favoriteProvider.addToFavorites(recipe);
          }
        },
        child: Consumer<FavoriteProviderCategory>(
          builder: (context, favoriteProvider, child) {
            final isFavorite = favoriteProvider.isRecipeFavorite(recipe);
            return Icon(isFavorite ? Icons.star : Icons.star_border);
          },
        ),
      ),
    );
  }

  Widget _buildRecipeTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        recipe.title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildIngredients(BuildContext context) {
    return ExpansionTile(
      title: const Text(
        "Ingredients",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: recipe.ingredients
              .map((ingredient) => _buildIngredientItem(ingredient))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildIngredientItem(String ingredient) {
    // You can replace this with your actual logic to get the amount of each ingredient
    String amount = "100g";

    return ListTile(
      title: Text(
        ingredient,
        style: const TextStyle(fontSize: 16),
      ),
      subtitle: Text(
        amount,
        style: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );
  }

  Widget _buildCookingSteps(BuildContext context) {
    return ExpansionTile(
      title: const Text(
        "Cooking Steps",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: recipe.cookingSteps
              .asMap()
              .map(
                (index, step) => MapEntry(
                  index,
                  ListTile(
                    leading: CircleAvatar(child: Text((index + 1).toString())),
                    title: Text(step),
                  ),
                ),
              )
              .values
              .toList(),
        ),
      ],
    );
  }
}
