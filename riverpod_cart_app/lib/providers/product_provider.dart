import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_cart_app/data/sample_products.dart';

final productListProvider = Provider((ref) {
  return sampleProducts;
});
