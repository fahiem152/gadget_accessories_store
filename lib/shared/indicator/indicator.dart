import 'package:flutter/material.dart';
import 'package:projecttas_223200007/shared/colors/colors.dart';
import 'package:projecttas_223200007/shared/textstyle/textstyle.dart';

extension BuildContextExtension on BuildContext {
  void showSnackBarError(String message) =>
      ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: ColorConstant.red,
          duration: const Duration(milliseconds: 500),
        ),
      );
  void showSnackBarSuccess(String message) =>
      ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: ColorConstant.blue,
          duration: const Duration(milliseconds: 500),
        ),
      );
  Widget showLoading() => Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Loading...",
              style: TextStyleConstant.textBlue.copyWith(
                fontSize: 16.0,
              ),
            ),
            const CircularProgressIndicator(
              color: ColorConstant.blue,
            ),
          ],
        ),
      );
}
