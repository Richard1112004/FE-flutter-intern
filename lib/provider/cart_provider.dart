import 'package:begining/api/cart/cart_API.dart';
import 'package:begining/cart/view_cart.dart';
import 'package:begining/model/CartItem.dart';
import 'package:begining/profile/my_profile.dart';
import 'package:begining/screen/home_screen.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  String selectionPlan = 'Choose';
  bool isCheckOut = false;
  final CartAPI _cartAPI = CartAPI();

  void setSelectionPlan(String plan) {
    selectionPlan = plan;
    notifyListeners();
  }

  String getSelectionPlan() {
    return selectionPlan;
  }

  void removeCartItem(CartItem cartItem) async {
    await _cartAPI.deleteCartItem(cartItem.id);
    notifyListeners();
  }

  void decreaseCartItemQuantity(CartItem cartItem) async {
    CartItem? targetItem;
    try {
      targetItem = CartItem.cartItems.firstWhere(
        (item) => !item.clear && item.id == cartItem.id,
      );
    } catch (_) {
      targetItem = null;
    }
    if (targetItem != null) {
      await _cartAPI.updateCartItemQuantity(cartItem.id, cartItem.quantity - 1);
    }
    notifyListeners();
  }

  void increaseCartItemQuantity(int product_id) async {
    CartItem? targetItem;
    try {
      targetItem = CartItem.cartItems.firstWhere(
        (item) => !item.clear && item.product_id == product_id,
      );
    } catch (_) {
      targetItem = null;
    }
    if (targetItem != null) {
      await _cartAPI.updateCartItemQuantity(targetItem.id, targetItem.quantity + 1);
    }
    notifyListeners();
  }

  void switchToCheckout() {
    isCheckOut = true;
    notifyListeners();
  }
}
