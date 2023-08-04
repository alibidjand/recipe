import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/data/sample-data.dart';
import 'package:recipe/model/data-model.dart';
import 'package:recipe/providers/favorite_provider_category.dart';
import 'package:recipe/screens/recipe-details-page.dart';
import 'package:recipe/widgets/custom_scaffold_widget.dart';

class CategoryDetailScreen extends StatelessWidget {
  final Category selectedCategory;

  const CategoryDetailScreen({Key? key, required this.selectedCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = context.watch<FavoriteProviderCategory>();
    final categoryRecipes = getCategoryRecipes(context, favoriteProvider);

    return CustomScaffold(
      // appBar: AppBar(
      //   title: Text(selectedCategory.name),
      //   centerTitle: true,
      //   bottom: PreferredSize(
      //     preferredSize: const Size.fromHeight(40),
      //     child: Padding(
      //       padding: const EdgeInsets.only(bottom: 8),
      //       child: Text(
      //         "Recipes in ${selectedCategory.name}: ${categoryRecipes.length}",
      //         style: const TextStyle(
      //           fontSize: 16,
      //           fontWeight: FontWeight.bold,
      //           color: Colors.white,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      drawer: _buildSideMenu(context),
      body: RecipeList(
        selectedCategory: selectedCategory,
        categoryRecipes: categoryRecipes,
        favoriteProvider: favoriteProvider,
      ),
      title: 'Items',
    );
  }

  Widget _buildSideMenu(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              "Menu",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            title: const Text("Categories"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            title: const Text("Favorites"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/favorites_list');
            },
          ),
        ],
      ),
    );
  }

  List<FoodRecipe> getCategoryRecipes(
    BuildContext context,
    FavoriteProviderCategory favoriteProvider,
  ) {
    return foodRecipes
        .where((recipe) => recipe.categoryId == selectedCategory.id)
        .toList();
  }
}

class RecipeList extends StatelessWidget {
  final Category selectedCategory;
  final List<FoodRecipe> categoryRecipes;
  final FavoriteProviderCategory favoriteProvider;

  const RecipeList({
    super.key,
    required this.selectedCategory,
    required this.categoryRecipes,
    required this.favoriteProvider,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categoryRecipes.length,
      itemBuilder: (context, index) {
        final recipe = categoryRecipes[index];
        return RecipeCard(
          recipe: recipe,
          isFavorite: favoriteProvider.isRecipeFavorite(recipe),
        );
      },
    );
  }
}

class RecipeCard extends StatelessWidget {
  final FoodRecipe recipe;
  final bool isFavorite;

  const RecipeCard({super.key, required this.recipe, required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailsPage(recipe: recipe),
          ),
        );
      },
      child: Card(
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                recipe.image,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    recipe.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    recipe.description,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${recipe.preparingTime} mins"),
                ),
                IconButton(
                  onPressed: () {
                    final favoriteProvider =
                        context.read<FavoriteProviderCategory>();
                    if (isFavorite) {
                      favoriteProvider.removeFromFavorites(recipe);
                    } else {
                      favoriteProvider.addToFavorites(recipe);
                    }
                  },
                  icon: Icon(isFavorite ? Icons.star : Icons.star_border),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
