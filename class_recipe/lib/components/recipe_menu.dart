import 'package:flutter/material.dart';

class RecipeMenu extends StatelessWidget {
  const RecipeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        children: [
          _buildMenuItem(Icons.food_bank, "ALL"),
          const SizedBox(width: 25),
          _buildMenuItem(Icons.coffee, "Coffee"),
          const SizedBox(width: 25),
          _buildMenuItem(Icons.fastfood, "Burger"),
          const SizedBox(width: 25),
          _buildMenuItem(Icons.local_pizza, "Pizza"),
        ],
      ),
    );
  }

  Container _buildMenuItem(IconData icon, String text) {
    return Container(
      height: 80,
      width: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.redAccent,
            size: 30.0,
          ),
          SizedBox(height: 5),
          Text(text)
        ],
      ),
    );
  }
}
