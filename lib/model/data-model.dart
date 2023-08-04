// ignore_for_file: file_names

class Category {
  final String id;
  final String name;
  final String image;

  Category({required this.id, required this.name, required this.image});
}

class FoodRecipe {
  final String title;
  final String description;
  final String image;
  final int preparingTime;
  final List<String> ingredients;
  final List<String> cookingSteps;
  final String categoryId;

  FoodRecipe({
    required this.title,
    required this.description,
    required this.image,
    required this.preparingTime,
    required this.ingredients,
    required this.cookingSteps,
    required this.categoryId,
  });
}
