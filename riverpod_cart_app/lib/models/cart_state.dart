import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_cart_app/models/cart_item.dart';

part 'cart_state.freezed.dart';

@freezed
class CartState with _$CartState {
  const factory CartState({
    @Default([]) List<CartItem> items,
    @Default(false) bool isLoading,
    String? error,
  }) = _CartState;
}
