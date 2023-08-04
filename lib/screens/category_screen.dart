import 'package:flutter/material.dart';
import 'package:recipe/model/data-model.dart';
import 'package:recipe/widgets/custom_scaffold_widget.dart';

import 'category_detail_screen.dart';

class CategoryScreen extends StatelessWidget {
  final List<Category> categories;

  const CategoryScreen({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      // appBar: AppBar(
      //   title: const Text("Food Recipes App"),
      // ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CategoryDetailScreen(selectedCategory: category),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(category.image),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(16),
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.all(8),
                child: Text(
                  category.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      title: 'Categories',
    );
  }
}
