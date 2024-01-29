import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projecttas_223200007/data/datasources/firebase_datasource/firebase_datasource.dart';
import 'package:projecttas_223200007/data/datasources/local_datasource/db_localdatasource.dart';
import 'package:projecttas_223200007/pages/admin/bottomnav_admin.dart';
import 'package:projecttas_223200007/pages/auth/forgot_password_page.dart';
import 'package:projecttas_223200007/pages/auth/register_page.dart';
import 'package:projecttas_223200007/pages/customer/bottomnav.dart';
import 'package:projecttas_223200007/shared/colors/colors.dart';
import 'package:projecttas_223200007/shared/indicator/indicator.dart';
import 'package:projecttas_223200007/shared/textstyle/textstyle.dart';
import 'package:projecttas_223200007/shared/validator/validator.dart';
import 'package:projecttas_223200007/shared/widgets/button_widget.dart';
import 'package:projecttas_223200007/shared/widgets/textformfield_border_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;
  doLogin(BuildContext context) async {
    isLoading = true;
    setState(() {});
    final result = await FirebaseDatasource()
        .login(email: emailcontroller.text, password: passwordcontroller.text);
    if (result.contains('Success Login')) {
      context.showSnackBarSuccess(result);
      if (emailcontroller.text == 'admin@gmail.com') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavAdmin()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BottomNav()),
        );
      }
    } else if (result.contains('Please verify your email')) {
      isLoading = false;
      setState(() {});
      await showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Info'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'Please verify your email first as we have already sent the verification email!'),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.currentUser!
                      .sendEmailVerification();
                  Navigator.pop(context);
                },
                child: const Text("Ok"),
              ),
            ],
          );
        },
      );
    } else {
      context.showSnackBarError(result);
    }
    isLoading = false;
    setState(() {});
  }

  doLoginWithGoogle() async {
    isLoading = true;
    setState(() {});
    final result = await FirebaseDatasource().signInWithGoogle();
    if (result) {
      context.showSnackBarSuccess("Success Login");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNav()),
      );
      DBLocalDatasource.setLoginGoogle(true);
    } else {
      context.showSnackBarError("Failed Login");
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome to Login",
                    style: TextStyleConstant.textWhite.copyWith(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text:
                            'Please fill E-mail & password to login your app account ',
                        style: TextStyleConstant.textWhite,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyleConstant.textYellow.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    12,
                  ),
                  topRight: Radius.circular(
                    12,
                  ),
                ),
              ),
              padding: const EdgeInsets.all(
                24,
              ),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "E-mail",
                      style: TextStyleConstant.textBlack.copyWith(
                        fontSize: 14.0,
                      ),
                    ),
                    TextFormFieldBorderWidget(
                      pleaceholder: 'gadgetaccessories@gmail.com',
                      controller: emailcontroller,
                      validator: (value) => Validator.email(value),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Password",
                      style: TextStyleConstant.textBlack.copyWith(
                        fontSize: 14.0,
                      ),
                    ),
                    TextFormFieldBorderWidget(
                      isPassword: true,
                      pleaceholder: '********',
                      controller: passwordcontroller,
                      validator: (value) => Validator.password(value),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage()),
                          );
                        },
                        child: Text(
                          "Forgot password?",
                          style: TextStyleConstant.textBlue.copyWith(
                            fontSize: 14.0,
                            fontWeight: bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    isLoading
                        ? context.showLoading()
                        : ButtonWidget(
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                doLogin(context);
                              }
                            },
                            color: ColorConstant.blue,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Text(
                                  'Login Now',
                                  style: TextStyleConstant.textWhite.copyWith(
                                    fontSize: 14.0,
                                    fontWeight: bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        doLoginWithGoogle();
                      },
                      child: Card(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Image.asset(
                              "assets/images/logo-google.png",
                              width: 40.0,
                              height: 40.0,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(
                    top: (MediaQuery.of(context).size.height * 0.2) - 40),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                width: 130,
                child: Image.asset(
                  'assets/images/logo-text.png',
                  width: 130,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
