import 'package:class_shopping_cart/components/shoppingcart_detail.dart';
import 'package:class_shopping_cart/constants.dart';
import 'package:flutter/material.dart';

class ShoppingcartHeader extends StatefulWidget {
  static int selectedId = 0;
  const ShoppingcartHeader({super.key});

  @override
  State<ShoppingcartHeader> createState() => _ShoppingcartHeaderState();
}

class _ShoppingcartHeaderState extends State<ShoppingcartHeader> {
  List<String> selectPic = [
    'assets/p1.jpeg',
    'assets/p2.jpeg',
    'assets/p3.jpeg',
    'assets/p4.jpeg'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: AspectRatio(
              aspectRatio: 5 / 3,
              child: Image.asset(
                selectPic[ShoppingcartHeader.selectedId],
                fit: BoxFit.cover,
              )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildIconButton(Icons.bike_scooter, 0),
              _buildIconButton(Icons.directions_bike, 1),
              _buildIconButton(Icons.directions_car, 2),
              _buildIconButton(Icons.airplanemode_active, 3),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildIconButton(IconData iconData, int id) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
          color: ShoppingcartHeader.selectedId == id
              ? kAccentColor
              : kSecondaryColor,
          borderRadius: BorderRadius.circular(20)),
      child: IconButton(
          onPressed: () {
            setState(() {
              ShoppingcartHeader.selectedId = id;
            });
          },
          icon: Icon(iconData)),
    );
  }
}
