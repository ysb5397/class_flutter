import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_cart_app/providers/cart_provider.dart';
import 'package:riverpod_cart_app/widgets/cart_item_title.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(cartProvider).items;
    final totalPrice = ref.watch(cartTotalPriceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("장바구니"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: items.isEmpty
          ? const Center(
              child: Text("장바구니가 비어있습니다."),
            )
          : ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return CartItemTitle(cartItem: items[index]);
              },
            ),
      bottomNavigationBar: items.isEmpty
          ? null
          : Container(
              padding: EdgeInsets.all(16),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "총액: $totalPrice원",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    ElevatedButton(onPressed: () {}, child: Text("주문하기"))
                  ],
                ),
              ),
            ),
    );
  }
}
