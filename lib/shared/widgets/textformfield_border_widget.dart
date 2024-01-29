// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:projecttas_223200007/shared/colors/colors.dart';
import 'package:projecttas_223200007/shared/textstyle/textstyle.dart';

class TextFormFieldBorderWidget extends StatelessWidget {
  final TextEditingController controller;
  final String pleaceholder;
  final String? Function(String?)? validator;
  final bool? isReadOnly;
  final bool? isPassword;
  final void Function(String)? onChanged;

  const TextFormFieldBorderWidget({
    Key? key,
    required this.controller,
    required this.pleaceholder,
    this.validator,
    this.isReadOnly = false,
    this.isPassword = false,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
      child: TextFormField(
        onChanged: onChanged,
        readOnly: isReadOnly!,
        obscureText: isPassword!,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          hintText: pleaceholder,
          hintStyle: TextStyleConstant.textBlack.copyWith(
            fontSize: 16,
            fontWeight: medium,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: ColorConstant.blue,
            ),
          ),
        ),
      ),
    );
  }
}
