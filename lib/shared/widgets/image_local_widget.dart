// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:projecttas_223200007/shared/colors/colors.dart';

class ImagesLocalWidget extends StatelessWidget {
  final File image;
  final VoidCallback onTap;
  const ImagesLocalWidget({
    Key? key,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.only(right: 4),
      width: 100,
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorConstant.grey,
        ),
        borderRadius: BorderRadius.circular(
          4,
        ),
      ),
      child: Stack(
        children: [
          Image.file(
            image,
            width: 100,
            height: 120,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: onTap,
              child: const Icon(
                Icons.close,
                color: ColorConstant.red,
              ),
            ),
          )
        ],
      ),
    );
  }
}
