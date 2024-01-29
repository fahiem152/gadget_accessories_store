import 'package:flutter/material.dart';
import 'package:projecttas_223200007/data/datasources/firebase_datasource/firebase_datasource.dart';
import 'package:projecttas_223200007/shared/colors/colors.dart';
import 'package:projecttas_223200007/shared/indicator/indicator.dart';
import 'package:projecttas_223200007/shared/textstyle/textstyle.dart';
import 'package:projecttas_223200007/shared/validator/validator.dart';
import 'package:projecttas_223200007/shared/widgets/button_widget.dart';
import 'package:projecttas_223200007/shared/widgets/textformfield_border_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    namecontroller.dispose();
    passwordcontroller.dispose();
    emailcontroller.dispose();
  }

  void doRegister(BuildContext context) async {
    isLoading = true;
    setState(() {});

    final result = await FirebaseDatasource().register(
        email: emailcontroller.text, password: passwordcontroller.text);
    if (result.contains('Failed:')) {
      context.showSnackBarError(result);
    } else {
      final createUser = await FirebaseDatasource().createUser(
        uid: result,
        email: emailcontroller.text,
        name: namecontroller.text,
      );
      if (createUser.contains('Success')) {
        isLoading = false;
        setState(() {});
        await showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Verification Email'),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                        'Please check your email, we have sent a verification email to your email address.!'),
                  ],
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Ok"),
                ),
              ],
            );
          },
        );
        Navigator.pop(context);
      } else {
        context.showSnackBarError(createUser);
      }
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
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
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(
                  top: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                width: 130,
                child: Image.asset(
                  'assets/images/logo-only.png',
                  width: 130,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: const Text(""),
            ),
            Container(
              margin: const EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 70.0,
                    ),
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 24),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 30.0,
                                ),
                                Text(
                                  "Sign Up",
                                  style: TextStyleConstant.textBlack.copyWith(
                                    fontSize: 16,
                                    fontWeight: bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                TextFormFieldBorderWidget(
                                  controller: namecontroller,
                                  pleaceholder: 'Name',
                                  validator: (value) => Validator.nama(value),
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                TextFormFieldBorderWidget(
                                  controller: emailcontroller,
                                  pleaceholder: 'Email',
                                  validator: (value) => Validator.email(value),
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                TextFormFieldBorderWidget(
                                  controller: passwordcontroller,
                                  pleaceholder: 'Password',
                                  validator: (value) =>
                                      Validator.password(value),
                                ),
                                const SizedBox(
                                  height: 40.0,
                                ),
                                isLoading == true
                                    ? context.showLoading()
                                    : ButtonWidget(
                                        onPressed: () {
                                          if (_formkey.currentState!
                                              .validate()) {
                                            doRegister(context);
                                          }
                                        },
                                        color: ColorConstant.blue,
                                        child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Center(
                                            child: Text(
                                              'Sign Up',
                                              style: TextStyleConstant.textWhite
                                                  .copyWith(
                                                fontSize: 14.0,
                                                fontWeight: bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 70.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyleConstant.textBlack,
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Login',
                              style: TextStyleConstant.textBlue.copyWith(
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
            ),
          ],
        ),
      ),
    );
  }
}
