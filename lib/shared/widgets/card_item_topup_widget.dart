// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:projecttas_223200007/data/models/top_up_model.dart';
import 'package:projecttas_223200007/shared/colors/colors.dart';
import 'package:projecttas_223200007/shared/formatter/formatter.dart';
import 'package:projecttas_223200007/shared/textstyle/textstyle.dart';

class CardItemTopupWidget extends StatelessWidget {
  final bool isAdmin;
  final TopUpModel topUp;
  const CardItemTopupWidget({
    Key? key,
    required this.isAdmin,
    required this.topUp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(topUp.timestamp);
    return Container(
      margin: const EdgeInsets.only(
        bottom: 8.0,
      ),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: ColorConstant.white,
        boxShadow: [
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
          Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: ColorConstant.blue,
              borderRadius: BorderRadius.circular(
                4,
              ),
            ),
            child: Image.asset(
              'assets/images/wallet.png',
              width: 80,
              height: isAdmin ? 90 : 80,
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isAdmin
                    ? Text(
                        '${topUp.userName}-${topUp.uid}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyleConstant.textBlack.copyWith(
                          fontSize: 12.0,
                        ),
                      )
                    : SizedBox(),
                Text(
                  Formatter.formatWaktuAndClock(dateTime),
                  style: TextStyleConstant.textBlack.copyWith(
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  "+ IDR ${Formatter.formatRupiah(topUp.amount)}",
                  style: TextStyleConstant.textBlack.copyWith(
                    fontSize: 14.0,
                    fontWeight: bold,
                  ),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: ColorConstant.lightGreen.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      topUp.status,
                      style: TextStyleConstant.textGreen.copyWith(
                        fontSize: 12.0,
                        fontWeight: bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
