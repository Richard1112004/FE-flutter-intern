import 'package:begining/cart/view_cart.dart';
import 'package:begining/model/CartItem.dart';
import 'package:begining/profile/my_profile.dart';
import 'package:begining/screen/home_screen.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  String selectionPlan = 'Choose';

  void setSelectionPlan(String plan) {
    selectionPlan = plan;
    notifyListeners();
  }

  String getSelectionPlan() {
    return selectionPlan;
  }

  removeCartItem(String productId) {
    CartItem.removeCurrentCartItem(productId);
    notifyListeners();
  }

  void decreaseCartItemQuantity(String product_id) {
    CartItem.decreaseCartItemQuantity(product_id);
    notifyListeners();
  }

  void increaseCartItemQuantity(String product_id) {
    CartItem.increaseCartItemQuantity(product_id);
    notifyListeners();
  }
}
