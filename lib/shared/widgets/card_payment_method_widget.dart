// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:projecttas_223200007/shared/colors/colors.dart';
import 'package:projecttas_223200007/shared/textstyle/textstyle.dart';

class CardPaymentMethodWidget extends StatelessWidget {
  final Map<String, dynamic> payment;
  const CardPaymentMethodWidget({
    Key? key,
    required this.payment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
      padding: const EdgeInsets.all(12.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ColorConstant.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 24,
            offset: Offset(0, 11),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 4.0,
          ),
          methodItem(
            "Type",
            payment['type'],
          ),
          const SizedBox(
            height: 2.0,
          ),
          methodItem(
            "Card Number",
            payment['cardNumber'],
          ),
          const SizedBox(
            height: 2.0,
          ),
          methodItem(
            "Cvv",
            payment['cvv'],
          ),
          const SizedBox(
            height: 2.0,
          ),
          methodItem(
            "Expiry Date",
            payment['expiryDate'],
          ),
          const SizedBox(
            height: 2.0,
          ),
        ],
      ),
    );
  }

  Widget methodItem(String key, String value) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            key,
            style: TextStyleConstant.textBlack.copyWith(
              fontSize: 14.0,
            ),
          ),
          Text(
            value,
            style: TextStyleConstant.textBlack.copyWith(
              fontSize: 14.0,
              fontWeight: bold,
            ),
          ),
        ],
      );
}
