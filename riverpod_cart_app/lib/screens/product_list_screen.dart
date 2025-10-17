import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_cart_app/providers/cart_provider.dart';
import 'package:riverpod_cart_app/providers/product_provider.dart';
import 'package:riverpod_cart_app/screens/cart_screen.dart';
import 'package:riverpod_cart_app/widgets/product_card.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productList = ref.watch(productListProvider);
    final cartItemCount = ref.watch(cartItemCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("상품 목록"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen()));
                },
                icon: Icon(Icons.shopping_cart),
                iconSize: 20,
              ),
              Positioned(
                right: 8,
                top: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                      child: Text(
                    "$cartItemCount",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )),
                ),
              )
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: productList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8),
          itemBuilder: (context, index) {
            return ProductCard(product: productList[index]);
          },
        ),
      ),
    );
  }
}
