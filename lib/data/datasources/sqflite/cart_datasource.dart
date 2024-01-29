import 'dart:developer';

import 'package:projecttas_223200007/data/models/product_model.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CartDatasource {
  static const String dbName = 'cart_database.db';
  static const String tableName = 'cart_items';

  Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $tableName(
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            price TEXT,
            images TEXT,
            quantity INTEGER)
        ''');
      },
    );
  }

  Future<bool> addToCart(ProductModel product) async {
    final db = await _openDatabase();

    final existingProduct = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [product.id],
    );

    if (existingProduct.isNotEmpty) {
      return false;
    } else {
      Map<String, dynamic> productToMap() {
        return {
          'id': product.id,
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'images': product.images.isNotEmpty ? product.images[0] : '',
          'quantity': 1,
        };
      }

      await db.insert(
        tableName,
        productToMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return true;
    }
  }

  Future<List<ProductModel>> getCartItems() async {
    try {
      final db = await _openDatabase();
      final List<Map<String, dynamic>> maps = await db.query(tableName);
      return List.generate(maps.length, (index) {
        final Map<String, dynamic> map = maps[index];
        final String image = map['images'];
        return ProductModel(
          id: map['id'] as String,
          name: map['name'] as String,
          description: map['description'] as String,
          price: map['price'] as String,
          images: [image],
          quantity: map['quantity'] as int,
        );
      });
    } catch (e) {
      log('Failed: $e');
      return [];
    }
  }

  Future<void> updateProductQuantity(String productId, int newQuantity) async {
    final db = await _openDatabase();
    if (newQuantity == 0) {
      // Jika newQuantity adalah 0, hapus produk dari database
      await db.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [productId],
      );
    } else {
      await db.update(
        tableName,
        {'quantity': newQuantity},
        where: 'id = ?',
        whereArgs: [productId],
      );
    }
  }

  Future<void> removeFromCart(String productId) async {
    final db = await _openDatabase();
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [productId],
    );
  }

  Future<void> clearCart() async {
    final db = await _openDatabase();
    await db.delete(tableName);
  }
}
