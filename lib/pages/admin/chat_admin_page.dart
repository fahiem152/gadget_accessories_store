import 'package:flutter/material.dart';
import 'package:projecttas_223200007/pages/chat/chats_page.dart';
import 'package:projecttas_223200007/pages/chat/users_page.dart';

class ChatAdminPage extends StatelessWidget {
  const ChatAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Users",
              ),
            ],
          ),
          title: const Text('Chat Page'),
        ),
        body: TabBarView(
          children: [
            // ChatsPage(
            //   isAdmin: true,
            // ),
            const UsersPage(
              isAdmin: true,
            ),
          ],
        ),
      ),
    );
  }
}
