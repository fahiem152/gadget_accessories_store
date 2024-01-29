import 'package:flutter/material.dart';
import 'package:projecttas_223200007/data/datasources/firebase_datasource/firebase_datasource.dart';
import 'package:projecttas_223200007/data/models/product_model.dart';
import 'package:projecttas_223200007/pages/admin/product/add_product_page.dart';
import 'package:projecttas_223200007/pages/admin/product/detail_product_page.dart';
import 'package:projecttas_223200007/shared/colors/colors.dart';
import 'package:projecttas_223200007/shared/textstyle/textstyle.dart';
import 'package:projecttas_223200007/shared/widgets/card_product_widget.dart';

class ManageProductPage extends StatelessWidget {
  const ManageProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Manage Products",
                style: TextStyleConstant.textBlack.copyWith(
                  fontSize: 20.0,
                  fontWeight: bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddProductPage()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConstant.lightBlue,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x19000000),
                        blurRadius: 24,
                        offset: Offset(0, 11),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Add",
                        style: TextStyleConstant.textWhite.copyWith(
                          fontSize: 14.0,
                        ),
                      ),
                      const Icon(
                        Icons.add,
                        color: ColorConstant.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24.0,
          ),
          Expanded(
            child: StreamBuilder<List<ProductModel>>(
              stream: FirebaseDatasource().getProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: ColorConstant.blue,
                    ),
                  );
                }

                List<ProductModel> products = snapshot.data ?? [];
                return GridView.builder(
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailProductPage(
                              product: product,
                              isAdmin: true,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
