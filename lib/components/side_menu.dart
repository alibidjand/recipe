import 'package:flutter/material.dart';
import 'package:recipe/data/sample-data.dart';
import 'package:recipe/screens/category_screen.dart';
import 'package:recipe/widgets/favorites_list.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Text(
              'Recipe App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Categories'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CategoryScreen(categories: categories)),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text('Favorites'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const FavoritesList()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // Perform logout action here
              // For example, you might clear the user session and navigate to the login screen.
            },
          ),
        ],
      ),
    );
  }
}
