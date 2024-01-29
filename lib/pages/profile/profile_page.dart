import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:projecttas_223200007/data/datasources/firebase_datasource/firebase_datasource.dart';
import 'package:projecttas_223200007/data/datasources/local_datasource/db_localdatasource.dart';
import 'package:projecttas_223200007/data/models/user_model.dart';
import 'package:projecttas_223200007/pages/auth/login_page.dart';
import 'package:projecttas_223200007/pages/profile/change_password_page.dart';
import 'package:projecttas_223200007/pages/profile/update_profile_page.dart';
import 'package:projecttas_223200007/shared/colors/colors.dart';
import 'package:projecttas_223200007/shared/indicator/indicator.dart';
import 'package:projecttas_223200007/shared/textstyle/textstyle.dart';
import 'package:projecttas_223200007/shared/widgets/button_widget.dart';
import 'package:projecttas_223200007/shared/widgets/profile_item_widget.dart';
import 'package:projecttas_223200007/shared/widgets/user_info_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  bool isLoading = false;
  UserModel? user;
  bool? isGoogle;
  @override
  void initState() {
    super.initState();
    doGetUser();
    isGoogle = DBLocalDatasource.getLoginGoogle();
  }

  doGetUser() async {
    final result = await FirebaseDatasource().getUserByUid(uid: uid);
    user = result;
    setState(() {});
  }

  doLogOut(BuildContext context) async {
    isLoading = true;
    setState(() {});
    if (isGoogle!) {
      GoogleSignIn().signOut();
      context.showSnackBarSuccess("Success Log Out");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } else {
      final result = await FirebaseDatasource().logout();
      if (result.contains('Success Log Out')) {
        context.showSnackBarSuccess(result);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        context.showSnackBarError(result);
      }
    }

    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: ListView(
        children: [
          const SizedBox(height: 20),
          user == null
              ? const Center(
                  child: CircularProgressIndicator(
                  color: ColorConstant.blue,
                ))
              : UserInfoWidget(user: user!),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
          ProfileItemWidget(
            title: 'Update Profile',
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UpdateProfilePage(
                          user: user!,
                        )),
              );
              doGetUser();
            },
          ),
          const SizedBox(height: 20),
          ProfileItemWidget(
            title: 'Change Password',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePasswordPage()),
              );
            },
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
          ProfileItemWidget(
            title: 'Contact Us',
          ),
          const SizedBox(height: 20),
          ProfileItemWidget(
            title: 'Privacy Policy',
          ),
          const SizedBox(height: 20),
          ProfileItemWidget(
            title: 'Terms and Conditions',
          ),
          const SizedBox(height: 40),
          isLoading
              ? context.showLoading()
              : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonWidget(
                    color: ColorConstant.red,
                    onPressed: () {
                      doLogOut(context);
                    },
                    child: Center(
                      child: Text(
                        "Log Out",
                        style: TextStyleConstant.textWhite.copyWith(
                          fontWeight: bold,
                        ),
                      ),
                    ),
                  ),
                ),
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Version 0.0.1",
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
          ),
          const SizedBox(height: 100)
        ],
      ),
    );
  }
}
