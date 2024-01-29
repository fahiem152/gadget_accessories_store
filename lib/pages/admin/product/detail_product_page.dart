// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:projecttas_223200007/data/datasources/firebase_datasource/firebase_datasource.dart';
import 'package:projecttas_223200007/data/models/product_model.dart';
import 'package:projecttas_223200007/data/service/cart_service.dart';
import 'package:projecttas_223200007/pages/admin/product/edit_product_page.dart';
import 'package:projecttas_223200007/shared/colors/colors.dart';
import 'package:projecttas_223200007/shared/formatter/formatter.dart';
import 'package:projecttas_223200007/shared/indicator/indicator.dart';
import 'package:projecttas_223200007/shared/textstyle/textstyle.dart';
import 'package:projecttas_223200007/shared/widgets/button_widget.dart';

class DetailProductPage extends StatefulWidget {
  final bool isAdmin;
  final ProductModel product;
  const DetailProductPage({
    Key? key,
    this.isAdmin = false,
    required this.product,
  }) : super(key: key);

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  bool isFavorite = false;
  CartService cartManager = CartService();

  doDelete(String productId, BuildContext context) async {
    final result = await FirebaseDatasource().deleteProduct(productId);
    if (result) {
      context.showSnackBarSuccess("Success Delete Product");
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      context.showSnackBarError("Failed Delete Product");
    }
  }

  addToCart(
    ProductModel model,
  ) async {
    final result = await cartManager.addToCart(model);
    if (result) {
      context.showSnackBarSuccess(
          "Product ${widget.product.name} added to the cart.");
    } else {
      context.showSnackBarError(
          "Product ${widget.product.name} is already in the cart.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
          height: 52,
          margin: const EdgeInsets.only(bottom: 8),
          child: widget.isAdmin
              ? Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ButtonWidget(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProductPage(
                                product: widget.product,
                              ),
                            ),
                          );
                        },
                        color: ColorConstant.yellow,
                        child: Center(
                          child: Text(
                            "Edit Product,",
                            style: TextStyleConstant.textWhite,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: ButtonWidget(
                        onPressed: () async {
                          await showDialog<void>(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirm'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text(
                                          'Are you sure you want to delete this item ${widget.product.name}?'),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorConstant.blue,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("No"),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorConstant.red,
                                    ),
                                    onPressed: () {
                                      doDelete(widget.product.id, context);
                                    },
                                    child: const Text("Yes"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        color: ColorConstant.red,
                        child: Center(
                          child: Text(
                            "Delete Product,",
                            style: TextStyleConstant.textWhite,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ButtonWidget(
                    onPressed: () {
                      addToCart(widget.product);
                    },
                    color: ColorConstant.blue,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Add to Cart",
                            style: TextStyleConstant.textWhite.copyWith(
                              fontWeight: bold,
                              fontSize: 16.0,
                            ),
                          ),
                          const Icon(
                            Icons.shopping_bag_outlined,
                            color: ColorConstant.white,
                            size: 32,
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              const SizedBox(
                height: 4.0,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height / 2,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                ),
                items: widget.product.images.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            i,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                height: 52,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ColorConstant.black3,
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: ColorConstant.white,
                        size: 32,
                      ),
                    ),
                    widget.isAdmin
                        ? const SizedBox()
                        : GestureDetector(
                            onTap: () {
                              addToCart(widget.product);
                            },
                            child: const Icon(
                              Icons.shopping_bag_outlined,
                              color: ColorConstant.white,
                              size: 32,
                            ),
                          )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: (MediaQuery.of(context).size.height / 2) + 24,
                  left: 24,
                  right: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.product.name,
                            style: TextStyleConstant.textBlack.copyWith(
                              fontSize: 18.0,
                              fontWeight: bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            isFavorite = !isFavorite;
                            setState(() {});
                          },
                          child: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: isFavorite
                                ? ColorConstant.red
                                : ColorConstant.blue,
                          ),
                        )
                      ],
                    ),
                    Text(
                      Formatter.formatRupiah(
                        int.parse(
                          widget.product.price,
                        ),
                      ),
                      style: TextStyleConstant.textBlue.copyWith(
                        fontSize: 16.0,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      widget.product.description,
                      style: TextStyleConstant.textBlack.copyWith(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      'Store Location: Jl. Rose Street, Melati Village, Rt 10 Rw 01, Mranggen Subdistrict, Demak Regency, Postal Code 59567',
                      style: TextStyleConstant.textBlack
                          .copyWith(fontSize: 14.0, fontWeight: light),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
