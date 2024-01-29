import 'dart:developer';

import 'package:projecttas_223200007/data/datasources/sqflite/cart_datasource.dart';
import 'package:projecttas_223200007/data/models/product_model.dart';

class CartService {
  final CartDatasource _dbCart = CartDatasource();

  Future<bool> addToCart(ProductModel product) async {
    try {
      final result = await _dbCart.addToCart(product);
      return result;
    } catch (e) {
      log('Error adding to cart: $e');
      return false;
    }
  }

  Future<List<ProductModel>> getCartContents() async {
    return await _dbCart.getCartItems();
  }

  Future<void> removeFromCart(ProductModel product) async {
    await _dbCart.removeFromCart(product.id);
  }

  Future<void> clearCart() async {
    await _dbCart.clearCart();
  }

  Future<void> updateQuantityCart(String productId, int newQuantity) async {
    await _dbCart.updateProductQuantity(productId, newQuantity);
  }
}
