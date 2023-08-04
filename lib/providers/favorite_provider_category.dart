import 'package:flutter/material.dart';
import 'package:recipe/model/data-model.dart';

class FavoriteProviderCategory with ChangeNotifier {
  final List<FoodRecipe> _favorites = [];

  List<FoodRecipe> get favorites => _favorites;

  // Add this method to get the favorite recipes
  List<FoodRecipe> getFavoriteRecipes() {
    return _favorites;
  }

  void addToFavorites(FoodRecipe recipe) {
    _favorites.add(recipe);
    notifyListeners();
  }

  void removeFromFavorites(FoodRecipe recipe) {
    _favorites.remove(recipe);
    notifyListeners();
  }

  bool isRecipeFavorite(FoodRecipe recipe) {
    return _favorites.contains(recipe);
  }
}
