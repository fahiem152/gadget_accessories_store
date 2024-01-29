// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:projecttas_223200007/data/models/user_model.dart';
import 'package:projecttas_223200007/shared/colors/colors.dart';
import 'package:projecttas_223200007/shared/formatter/formatter.dart';
import 'package:projecttas_223200007/shared/textstyle/textstyle.dart';

class CardWalletWidget extends StatelessWidget {
  final UserModel user;
  const CardWalletWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12,
        ),
        color: ColorConstant.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 24,
            offset: Offset(0, 11),
          ),
        ],
      ),
      child: Stack(
        children: [
          cardPattern(),
          membershipBanner(),
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              'assets/images/wallet.png',
              width: 140,
              height: 120,
            ),
          ),
          cardContent(),
        ],
      ),
    );
  }

  Widget cardPattern() => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            3,
            (rowIndex) => Row(
              children: List.generate(
                rowIndex + 4,
                (columnOndex) => Container(
                  width: 40,
                  height: 40,
                  margin: EdgeInsets.only(
                    left: columnOndex == 0 ? 3 : 0,
                    right: 3,
                    bottom: 4,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorConstant.blue
                            .withOpacity((0.025 * (rowIndex + 1)) + 0.05),
                        ColorConstant.blue
                            .withOpacity((0.025 * rowIndex) + 0.05),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: columnOndex == 0 && rowIndex == 0
                          ? const Radius.circular(10)
                          : Radius.circular(4),
                      bottomLeft: columnOndex == 0 && rowIndex == 0
                          ? const Radius.circular(10)
                          : Radius.circular(4),
                      topRight: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
  Widget membershipBanner() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Align(
            alignment: Alignment.centerRight,
            child: Transform.rotate(
              angle: pi / 2,
              origin: const Offset(
                30.5,
                30.5,
              ),
              child: Container(
                width: 150,
                height: 30,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      10,
                    ),
                    topRight: Radius.circular(
                      10,
                    ),
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
                child: Center(
                  child: Text(
                    "P R I O R I T Y",
                    style: TextStyleConstant.textWhite.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
  Widget cardContent() => Padding(
        padding: const EdgeInsets.fromLTRB(
          20,
          10,
          50,
          10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Current Balance",
              style: TextStyleConstant.textBlack.copyWith(
                fontSize: 12.0,
              ),
            ),
            Text(
              Formatter.formatRupiah(user.balance),
              style: TextStyleConstant.textBlue.copyWith(
                fontSize: 18.0,
                fontWeight: bold,
              ),
            ),
            Text(user.name,
                style: TextStyleConstant.textBlack.copyWith(
                  fontWeight: bold,
                )),
          ],
        ),
      );
}
