// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projecttas_223200007/data/datasources/firebase_datasource/firebase_datasource.dart';

import 'package:projecttas_223200007/data/models/product_model.dart';
import 'package:projecttas_223200007/data/models/transaction_model.dart';
import 'package:projecttas_223200007/data/models/user_model.dart';
import 'package:projecttas_223200007/data/service/cart_service.dart';
import 'package:projecttas_223200007/pages/customer/bottomnav.dart';
import 'package:projecttas_223200007/shared/colors/colors.dart';
import 'package:projecttas_223200007/shared/formatter/formatter.dart';
import 'package:projecttas_223200007/shared/indicator/indicator.dart';
import 'package:projecttas_223200007/shared/textstyle/textstyle.dart';
import 'package:projecttas_223200007/shared/utils/auth_utils.dart';
import 'package:projecttas_223200007/shared/widgets/button_widget.dart';
import 'package:projecttas_223200007/shared/widgets/card_checkout_widget.dart';
import 'package:projecttas_223200007/shared/widgets/card_wallet_widget.dart';

class CheckoutPage extends StatefulWidget {
  List<ProductModel> products;
  CheckoutPage({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isLoading = false;
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  loadUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    userModel = await FirebaseDatasource().getUserByUid(uid: user!.uid);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<int> productQuantity = widget.products.map((e) => e.quantity).toList();
    int totalQuantityProduct = productQuantity.fold(
        0, (previousValue, element) => previousValue + element);
    int totalPriceProduct = widget.products.map((product) {
      return product.quantity * int.parse(product.price);
    }).fold(0, (int sum, int number) {
      return sum + number;
    });

    int total = totalPriceProduct + 3000;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.blue,
        centerTitle: true,
        title: Text(
          "Checkout Page",
          style: TextStyleConstant.textWhite,
        ),
        actions: const [],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          height: 52,
          child: isLoading
              ? context.showLoading()
              : ButtonWidget(
                  onPressed: () async {
                    isLoading = true;
                    setState(() {});
                    Map<String, dynamic> payment = {
                      'type': 'Credit Card',
                      'cardNumber': "**** **** **** 1234",
                      'expiryDate': "12/30",
                      'cvv': "123"
                    };

                    final model = TransactionModel(
                        id: 'id',
                        uid: AuthUtils.getCurrentUserID() ?? 'no-uid',
                        items: widget.products.map((product) {
                          int subTotal =
                              product.quantity * int.parse(product.price);
                          return {
                            'id': product.id,
                            'name': product.name,
                            'price': product.price,
                            'images': product.images,
                            'quantity': product.quantity,
                            'subtotal': subTotal.toString(),
                          };
                        }).toList(),
                        subtotal: totalPriceProduct.toString(),
                        adminFee: "3000",
                        total: total.toString(),
                        paymentMethod: payment,
                        transactionTime: DateTime.now().millisecondsSinceEpoch);
                    final result =
                        await FirebaseDatasource().addTransaction(model);
                    if (result.contains('successfully')) {
                      await CartService().clearCart();
                      context.showSnackBarSuccess(result);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => BottomNav()),
                        (route) =>
                            false, // Hapus semua rute sebelumnya dari tumpukan navigasi
                      );
                    } else if (result.contains('Insufficient funds')) {
                      context.showSnackBarError(result);
                    } else if (result.contains('User failed')) {
                      context.showSnackBarError(result);
                    } else {
                      context.showSnackBarError(result);
                    }

                    isLoading = false;
                    setState(() {});
                  },
                  color: ColorConstant.blue,
                  child: Center(
                    child: Text(
                      "Pay",
                      style: TextStyleConstant.textWhite.copyWith(
                        fontWeight: bold,
                        fontSize: 16.0,
                      ),
                    ),
                  )),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: userModel == null
            ? Center(
                child: CircularProgressIndicator(
                  color: ColorConstant.blue,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    CardWalletWidget(user: userModel!),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/logo-only.png',
                          width: 40,
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Expanded(
                          child: Text(
                            "Gadget Accessories Store",
                            style: TextStyleConstant.textBlack,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    ListView.builder(
                      itemCount: widget.products.length,
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return CardCheckoutWidget(
                          product: widget.products[index],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                        gradient: const LinearGradient(
                          colors: [
                            ColorConstant.blue,
                            ColorConstant.lightBlue,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "Total Price ($totalQuantityProduct Product)",
                                  style: TextStyleConstant.textWhite,
                                ),
                              ),
                              const SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                Formatter.formatRupiah(totalPriceProduct),
                                style: TextStyleConstant.textWhite.copyWith(
                                  fontWeight: bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "Admin Fee",
                                  style: TextStyleConstant.textWhite,
                                ),
                              ),
                              const SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                Formatter.formatRupiah(3000),
                                style: TextStyleConstant.textWhite.copyWith(
                                  fontWeight: bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          const Divider(
                            color: ColorConstant.white,
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text("Total Payment",
                                    style: TextStyleConstant.textWhite.copyWith(
                                      fontSize: 16.0,
                                      fontWeight: medium,
                                    )),
                              ),
                              const SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                Formatter.formatRupiah(total),
                                style: TextStyleConstant.textWhite.copyWith(
                                  fontWeight: bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Note*: ',
                        style: TextStyleConstant.textBlack
                            .copyWith(fontSize: 12.0, fontWeight: bold),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'Once purchased, items cannot be returned. Please review your order carefully before completing the transaction.',
                            style: TextStyleConstant.textBlack.copyWith(
                              fontSize: 12.0,
                              fontWeight: reguler,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
