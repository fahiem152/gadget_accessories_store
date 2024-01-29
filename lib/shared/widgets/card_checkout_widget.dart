// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:projecttas_223200007/data/models/product_model.dart';
import 'package:projecttas_223200007/shared/colors/colors.dart';
import 'package:projecttas_223200007/shared/formatter/formatter.dart';
import 'package:projecttas_223200007/shared/textstyle/textstyle.dart';

class CardCheckoutWidget extends StatelessWidget {
  final ProductModel product;
  const CardCheckoutWidget({
    Key? key,
    required this.product,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int totalPrice = int.parse(product.price) * product.quantity;

    return Container(
      height: 112,
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      decoration: BoxDecoration(
        color: ColorConstant.white,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                product.images[0],
                width: MediaQuery.of(context).size.width / 4,
                height: 112,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyleConstant.textBlack.copyWith(
                      fontSize: 14.0,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    Formatter.formatRupiah(int.parse(product.price)) +
                        " x ${product.quantity}",
                    style: TextStyleConstant.textBlack.copyWith(
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    Formatter.formatRupiah(totalPrice),
                    style: TextStyleConstant.textBlack.copyWith(
                      fontSize: 14.0,
                      fontWeight: bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 4.0,
          ),
        ],
      ),
    );
  }
}
