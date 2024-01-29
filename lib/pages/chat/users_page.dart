// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:projecttas_223200007/data/datasources/firebase_datasource/chat_datasource.dart';
import 'package:projecttas_223200007/data/models/user_model.dart';
import 'package:projecttas_223200007/pages/chat/room_chat_page.dart';
import 'package:projecttas_223200007/shared/colors/colors.dart';
import 'package:projecttas_223200007/shared/textstyle/textstyle.dart';

class UsersPage extends StatefulWidget {
  final bool isAdmin;
  const UsersPage({
    Key? key,
    required this.isAdmin,
  }) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          widget.isAdmin
              ? const SizedBox()
              : Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(12.0),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        ColorConstant.blue,
                        ColorConstant.lightBlue,
                      ],
                    ),
                  ),
                  child: Text(
                    "Contact Admin",
                    style: TextStyleConstant.textWhite.copyWith(
                      fontSize: 20.0,
                      fontWeight: bold,
                    ),
                  ),
                ),
          Expanded(
            child: StreamBuilder<List<UserModel>>(
                stream: widget.isAdmin
                    ? FirebaseDatasource.instance.allUser()
                    : FirebaseDatasource.instance
                        .findUserByEmail('admin@gmail.com'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final List<UserModel> users = (snapshot.data ?? [])
                      .where((element) => element.uid != currentUser!.uid)
                      .toList();
                  //if user is null
                  if (users.isEmpty) {
                    return const Center(
                      child: Text('No user found'),
                    );
                  }
                  return ListView.separated(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 25,
                            child: Text(users[index].name[0].toUpperCase(),
                                style: const TextStyle(color: Colors.white)),
                          ),
                          title: Text(users[index].name),
                          subtitle: const Text('Last message'),
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return RoomChatPage(
                                partnerUser: users[index],
                              );
                            }));
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      });
                }),
          ),
        ],
      ),
    );
  }
}
