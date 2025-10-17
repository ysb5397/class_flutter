import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_cart_app/models/cart_item.dart';
import 'package:riverpod_cart_app/providers/cart_provider.dart';

class CartItemTitle extends ConsumerWidget {
  final CartItem cartItem;

  const CartItemTitle({required this.cartItem, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: Image.network(cartItem.product.imageUrl ?? ""),
            ),
            SizedBox(width: 12),
            Expanded(child: Text("${cartItem.product.price}원")),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      ref.read(cartProvider.notifier).updateQuantity(
                          cartItem.product.id, cartItem.quantity - 1);
                    },
                    icon: Icon(Icons.remove)),
                Text("${cartItem.quantity}"),
                IconButton(
                    onPressed: () {
                      ref.read(cartProvider.notifier).updateQuantity(
                          cartItem.product.id, cartItem.quantity + 1);
                    },
                    icon: Icon(Icons.add))
              ],
            )
          ],
        ),
      ),
    );
  }
}
