import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:projecttas_223200007/pages/chat/users_page.dart';
import 'package:projecttas_223200007/pages/customer/home_page.dart';
import 'package:projecttas_223200007/pages/profile/profile_page.dart';
import 'package:projecttas_223200007/pages/transaction/transactions_page.dart';
import 'package:projecttas_223200007/pages/wallet/wallet_page.dart';
import 'package:projecttas_223200007/shared/colors/colors.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentTabIndex = 0;

  List<Widget> pages = [
    const HomePage(),
    const TransactionsPage(isAdmin: false),
    const WalletPage(isAdmin: false),
    UsersPage(
      isAdmin: false,
    ),
    // const ChatPage(
    //     partnerUser: UserModel(
    //         uid: 'T0jc8GKPdsc72nCdWc70x0pZ2ZG2',
    //         email: 'admin@gmail.com',
    //         name: 'Admin')),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.white,
      bottomNavigationBar: CurvedNavigationBar(
          height: 65,
          backgroundColor: Colors.white,
          color: ColorConstant.blue,
          animationDuration: const Duration(milliseconds: 500),
          onTap: (int index) {
            setState(() {
              currentTabIndex = index;
            });
          },
          items: const [
            Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.wallet_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.chat_bubble_outline,
              color: Colors.white,
            ),
            Icon(
              Icons.person_outline,
              color: Colors.white,
            )
          ]),
      body: SafeArea(child: pages[currentTabIndex]),
    );
  }
}
