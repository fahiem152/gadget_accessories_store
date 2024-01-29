// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:projecttas_223200007/data/models/transaction_model.dart';
import 'package:projecttas_223200007/shared/colors/colors.dart';
import 'package:projecttas_223200007/shared/formatter/formatter.dart';
import 'package:projecttas_223200007/shared/textstyle/textstyle.dart';

class CardTransactionWidget extends StatelessWidget {
  final VoidCallback onTap;
  final TransactionModel transaction;
  const CardTransactionWidget({
    Key? key,
    required this.onTap,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(transaction.transactionTime);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
        decoration: BoxDecoration(
          color: ColorConstant.white,
          borderRadius: BorderRadius.circular(
            8,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 24,
              offset: Offset(0, 11),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8,
              ),
              decoration: const BoxDecoration(
                color: ColorConstant.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    8,
                  ),
                  topRight: Radius.circular(
                    8,
                  ),
                ),
              ),
              child: Text(
                transaction.id,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyleConstant.textWhite.copyWith(
                  fontSize: 12.0,
                  fontWeight: bold,
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                    child: Image.network(
                      transaction.items[0]['images'][0],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Formatter.formatWaktuAndClock(dateTime),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyleConstant.textBlack.copyWith(
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          "${transaction.items.length} Product",
                          style: TextStyleConstant.textBlack.copyWith(
                            fontSize: 12.0,
                            fontWeight: light,
                          ),
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          Formatter.formatRupiah(
                            int.parse(
                              transaction.total,
                            ),
                          ),
                          style: TextStyleConstant.textBlack.copyWith(
                            fontSize: 14.0,
                            fontWeight: bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 4.0,
            ),
          ],
        ),
      ),
    );
  }
}
