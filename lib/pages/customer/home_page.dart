import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projecttas_223200007/data/datasources/firebase_datasource/firebase_datasource.dart';
import 'package:projecttas_223200007/data/models/product_model.dart';
import 'package:projecttas_223200007/data/service/cart_service.dart';
import 'package:projecttas_223200007/pages/admin/product/detail_product_page.dart';
import 'package:projecttas_223200007/pages/customer/cart_page.dart';
import 'package:projecttas_223200007/shared/colors/colors.dart';
import 'package:projecttas_223200007/shared/textstyle/textstyle.dart';
import 'package:projecttas_223200007/shared/widgets/card_product_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  String search = '';
  List<String> imageBanner = [
    'https://asset-2.tstatic.net/sultra/foto/bank/images/promo-weekend-roxy-kendari.jpg',
    'https://asset-2.tstatic.net/sultra/foto/bank/images/promo-selera-kamu-roxy-kendari.jpg',
    'https://mirage-online.com/wp-content/uploads/2023/04/Spare-Part-Aksesoris-HP-Lengkap.jpg',
    'https://asset-2.tstatic.net/manado/foto/bank/images/importir-accessories-spesial-menghadirkan-discount-sampai-dengan-50-untuk-produk-terbaiknya.jpg',
  ];
  List<ProductModel> products = [];
  List<ProductModel> cartProducts = [];
  @override
  void initState() {
    super.initState();
    loadCartProducts();
    loadDataProducts();
  }

  void loadDataProducts() async {
    products = await FirebaseDatasource().getProductsV2();

    setState(() {});
  }

  void loadCartProducts() async {
    cartProducts = await CartService().getCartContents();
    setState(() {});
  }

  void performSearch(String search) {
    if (search == '') {
      loadDataProducts();
    }
    List<ProductModel> searchResults = products
        .where((product) =>
            product.name.toLowerCase().contains(search.toLowerCase()))
        .toList();

    setState(() {
      products =
          searchResults; // Mengganti nilai variabel products dengan hasil pencarian
    });
  }

  @override
  Widget build(BuildContext context) {
    log("AUTH CURRENT: ${auth.currentUser}");
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3,
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ColorConstant.blue,
                ColorConstant.lightBlue,
              ],
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(
                          0.2,
                        ),
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            color: ColorConstant.white,
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration.collapsed(
                                hintText: "Seacrh Product Here...",
                                hintStyle: TextStyleConstant.textWhite,
                              ),
                              style: TextStyleConstant.textWhite,
                              onChanged: (value) {
                                search = value;
                                performSearch(search);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CartPage()),
                      );
                      loadCartProducts();
                    },
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                          size: 32,
                        ),
                        cartProducts.isEmpty
                            ? SizedBox()
                            : Badge.count(
                                count: cartProducts.length,
                                backgroundColor: ColorConstant.red,
                              ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 150.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                ),
                items: imageBanner.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
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
                            height: 150.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: (MediaQuery.of(context).size.height / 3) + 24,
            left: 24,
            right: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Products",
                style: TextStyleConstant.textBlack.copyWith(
                  fontSize: 16.0,
                  fontWeight: bold,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                  child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 4 / 7,
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: products.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  final product = products[index];
                  return CardProductWidget(
                    product: product,
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailProductPage(
                            product: product,
                          ),
                        ),
                      );
                      loadCartProducts();
                    },
                  );
                },
              )),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
