import 'package:flutter/material.dart';
import 'package:projecttas_223200007/shared/colors/colors.dart';

class CardItemWalletWidget extends StatelessWidget {
  const CardItemWalletWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(
        bottom: 12.0,
      ),
      decoration: BoxDecoration(
        color: ColorConstant.white,
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      child: Column(
        children: [
          Text(
            "text",
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
