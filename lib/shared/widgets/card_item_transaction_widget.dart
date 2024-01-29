// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:projecttas_223200007/shared/colors/colors.dart';
import 'package:projecttas_223200007/shared/formatter/formatter.dart';
import 'package:projecttas_223200007/shared/textstyle/textstyle.dart';

class CardItemTransactionWidget extends StatelessWidget {
  final DateTime date;
  final Map<String, dynamic> item;
  const CardItemTransactionWidget({
    Key? key,
    required this.date,
    required this.item,
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.shopping_bag,
                color: ColorConstant.blue,
              ),
              const SizedBox(
                width: 8.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Shopping",
                    style: TextStyleConstant.textBlack.copyWith(
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    Formatter.formatWaktu(date),
                    style: TextStyleConstant.textBlack.copyWith(
                      fontSize: 12.0,
                      fontWeight: bold,
                    ),
                  )
                ],
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: ColorConstant.lightGreen.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(
                    4,
                  ),
                ),
                child: Text(
                  "Success",
                  style: TextStyleConstant.textGreen.copyWith(
                    fontSize: 12.0,
                    fontWeight: bold,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          Divider(
            color: ColorConstant.black3,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  8,
                ),
                child: Image.network(
                  item['images'][0],
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
                      item['name'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleConstant.textBlack.copyWith(
                        fontSize: 14.0,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      "${item['quantity']} Item",
                      style: TextStyleConstant.textBlack.copyWith(
                        fontSize: 12.0,
                        fontWeight: light,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Price",
                            style: TextStyleConstant.textBlack.copyWith(
                              fontSize: 10.0,
                              fontWeight: light,
                            ),
                          ),
                          Text(
                            Formatter.formatRupiah(int.parse(item['subtotal'])),
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
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }
}
