import 'package:begining/cart/view_cart.dart';
import 'package:begining/model/CartItem.dart';
import 'package:begining/profile/my_profile.dart';
import 'package:begining/screen/home_screen.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  String selectionPlan = 'Choose';
  bool isCheckOut = false;

  void setSelectionPlan(String plan) {
    selectionPlan = plan;
    notifyListeners();
  }

  String getSelectionPlan() {
    return selectionPlan;
  }

  removeCartItem(int productId) {
    CartItem.removeCurrentCartItem(productId);
    notifyListeners();
  }

  void decreaseCartItemQuantity(int product_id) {
    CartItem.decreaseCartItemQuantity(product_id);
    notifyListeners();
  }

  void increaseCartItemQuantity(int product_id) {
    CartItem.increaseCartItemQuantity(product_id);
    notifyListeners();
  }

  void switchToCheckout() {
    isCheckOut = true;
    notifyListeners();
  }
}
