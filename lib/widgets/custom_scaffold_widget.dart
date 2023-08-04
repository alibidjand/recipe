import 'package:flutter/material.dart';
import 'package:recipe/components/side_menu.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final FloatingActionButton? floatingActionButton;
  final Widget? drawer;

  const CustomScaffold({
    super.key,
    required this.body,
    required this.title,
    this.floatingActionButton,
    this.drawer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      endDrawer: const SideMenu(), // Add the SideMenu widget as the endDrawer
      body: body,
    );
  }
}
