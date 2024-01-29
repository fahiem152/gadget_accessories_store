import 'package:flutter/material.dart';
import 'package:projecttas_223200007/data/models/product_model.dart';
import 'package:projecttas_223200007/data/service/cart_service.dart';
import 'package:projecttas_223200007/pages/customer/checkout_page.dart';
import 'package:projecttas_223200007/shared/colors/colors.dart';
import 'package:projecttas_223200007/shared/formatter/formatter.dart';
import 'package:projecttas_223200007/shared/textstyle/textstyle.dart';
import 'package:projecttas_223200007/shared/widgets/button_widget.dart';
import 'package:projecttas_223200007/shared/widgets/card_cart_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<ProductModel> products = [];
  bool isLoading = false;
  void getProducts() async {
    setState(() {
      isLoading = true;
    });
    products = await CartService().getCartContents();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    // List<int> totalPrice = products.map((product) {
    //   return product.quantity * int.parse(product.price);
    // }).toList();
    // int totalSum = totalPrice.fold(0, (int sum, int number) {
    //   return sum + number;
    // });
    int totalSum = products.map((product) {
      return product.quantity * int.parse(product.price);
    }).fold(0, (int sum, int number) {
      return sum + number;
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorConstant.blue,
        title: Text(
          "Cart Page",
          style: TextStyleConstant.textWhite,
        ),
        actions: const [],
      ),
      bottomNavigationBar: products.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                height: 52,
                child: ButtonWidget(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckoutPage(
                                  products: products,
                                )),
                      );
                    },
                    color: ColorConstant.blue,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Checkout',
                            style: TextStyleConstant.textWhite.copyWith(
                              fontSize: 14.0,
                            ),
                          ),
                          Text(
                            Formatter.formatRupiah(totalSum),
                            style: TextStyleConstant.textWhite.copyWith(
                              fontSize: 14.0,
                              fontWeight: bold,
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: products.isEmpty
            ? Center(
                child: Text(
                  "Your cart is currently empty",
                  style: TextStyleConstant.textBlack,
                ),
              )
            : ListView.builder(
                itemCount: products.length,
                physics: const ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return CardCartWidget(
                    product: products[index],
                    onTapIncrement: () async {
                      await CartService().updateQuantityCart(
                          products[index].id, products[index].quantity + 1);
                      setState(() {});
                      getProducts();
                    },
                    onTapDecrement: () async {
                      await CartService().updateQuantityCart(
                          products[index].id, products[index].quantity - 1);
                      setState(() {});
                      getProducts();
                    },
                    onTapDelete: () async {
                      await CartService().removeFromCart(products[index]);
                      getProducts();
                    },
                  );
                },
              ),
      ),
    );
  }
}
