// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:projecttas_223200007/data/models/product_model.dart';
import 'package:projecttas_223200007/shared/colors/colors.dart';
import 'package:projecttas_223200007/shared/formatter/formatter.dart';
import 'package:projecttas_223200007/shared/textstyle/textstyle.dart';

class CardProductWidget extends StatelessWidget {
  final VoidCallback onTap;
  final ProductModel product;
  const CardProductWidget({
    Key? key,
    required this.onTap,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              8,
            ),
          ),
          color: ColorConstant.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(
                      8,
                    ),
                    topLeft: Radius.circular(
                      8,
                    ),
                  ),
                  child: Image.network(
                    product.images[0],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyleConstant.textBlack.copyWith(
                    fontWeight: medium,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  Formatter.formatRupiah(int.parse(product.price)),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyleConstant.textBlue.copyWith(
                    fontWeight: medium,
                  ),
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
            ],
          )),
    );
  }
}
