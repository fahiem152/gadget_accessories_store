// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ProfileItemWidget extends StatelessWidget {
  VoidCallback? onTap;
  final String title;
  ProfileItemWidget({
    Key? key,
    this.onTap,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
