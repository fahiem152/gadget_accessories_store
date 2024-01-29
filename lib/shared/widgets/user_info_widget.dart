// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:projecttas_223200007/data/models/user_model.dart';

class UserInfoWidget extends StatelessWidget {
  final UserModel user;
  const UserInfoWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
            image: DecorationImage(
              image: user.photoUrl != null
                  ? NetworkImage(user.photoUrl!) as ImageProvider
                  : const AssetImage(
                      'assets/images/human.jpg',
                    ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          user.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          user.email,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
