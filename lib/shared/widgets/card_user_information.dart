// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:projecttas_223200007/data/models/user_model.dart';
import 'package:projecttas_223200007/shared/colors/colors.dart';
import 'package:projecttas_223200007/shared/textstyle/textstyle.dart';

class CardUserInformation extends StatelessWidget {
  final UserModel user;
  const CardUserInformation({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 4.0,
          ),
          methodItem("UID", user.uid),
          methodItem("Name", user.name),
          methodItem("E-mail", user.email),
        ],
      ),
    );
  }

  Widget methodItem(String key, String value) => Padding(
        padding: const EdgeInsets.only(
          top: 2.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              key,
              style: TextStyleConstant.textWhite.copyWith(
                fontSize: 14.0,
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Text(
              value,
              style: TextStyleConstant.textWhite.copyWith(
                fontSize: 14.0,
                fontWeight: bold,
              ),
            ),
          ],
        ),
      );
}
