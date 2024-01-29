import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:projecttas_223200007/pages/admin/chat_admin_page.dart';
import 'package:projecttas_223200007/pages/admin/product/manage_product_page.dart';
import 'package:projecttas_223200007/pages/profile/profile_page.dart';
import 'package:projecttas_223200007/pages/transaction/transactions_page.dart';
import 'package:projecttas_223200007/pages/wallet/wallet_page.dart';
import 'package:projecttas_223200007/shared/colors/colors.dart';

class BottomNavAdmin extends StatefulWidget {
  const BottomNavAdmin({super.key});

  @override
  State<BottomNavAdmin> createState() => _BottomNavAdminState();
}

class _BottomNavAdminState extends State<BottomNavAdmin> {
  int currentTabIndex = 0;

  List<Widget> pages = [
    const ManageProductPage(),
    const TransactionsPage(isAdmin: true),
    WalletPage(isAdmin: true),
    ChatAdminPage(),
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
