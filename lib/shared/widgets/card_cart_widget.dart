// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:projecttas_223200007/data/models/product_model.dart';
import 'package:projecttas_223200007/shared/colors/colors.dart';
import 'package:projecttas_223200007/shared/formatter/formatter.dart';
import 'package:projecttas_223200007/shared/textstyle/textstyle.dart';

class CardCartWidget extends StatelessWidget {
  final VoidCallback onTapIncrement;
  final VoidCallback onTapDecrement;
  final VoidCallback onTapDelete;
  final ProductModel product;
  const CardCartWidget({
    Key? key,
    required this.onTapIncrement,
    required this.onTapDecrement,
    required this.onTapDelete,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          GestureDetector(
            onTap: onTapDelete,
            child: Container(
              height: 112,
              width: 20,
              decoration: const BoxDecoration(
                color: ColorConstant.red,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    8,
                  ),
                  bottomLeft: Radius.circular(
                    8,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var letter in 'Delete'.split(''))
                    Text(
                      letter,
                      style: TextStyleConstant.textWhite.copyWith(
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
          ),
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
                      fontWeight: bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    Formatter.formatRupiah(int.parse(product.price)),
                    style: TextStyleConstant.textBlack.copyWith(
                      fontSize: 14.0,
                      fontWeight: bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 4.0,
          ),
          Container(
            height: 112,
            width: 48,
            decoration: const BoxDecoration(
              color: ColorConstant.blue,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(
                  8,
                ),
                bottomRight: Radius.circular(
                  8,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: onTapIncrement,
                  child: const Icon(
                    Icons.add_circle,
                    color: ColorConstant.white,
                  ),
                ),
                Text(
                  "${product.quantity}",
                  style: TextStyleConstant.textWhite.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: onTapDecrement,
                  child: const Icon(
                    Icons.remove_circle,
                    color: ColorConstant.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
