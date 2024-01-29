import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projecttas_223200007/shared/colors/colors.dart';
import 'package:projecttas_223200007/shared/indicator/indicator.dart';
import 'package:projecttas_223200007/shared/textstyle/textstyle.dart';
import 'package:projecttas_223200007/shared/validator/validator.dart';
import 'package:projecttas_223200007/shared/widgets/button_widget.dart';
import 'package:projecttas_223200007/shared/widgets/textformfield_border_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  void dispose() {
    emailcontroller.dispose();
    super.dispose();
  }

  doReset(BuildContext context) async {
    isLoading = true;
    setState(() {});
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailcontroller.text);

    isLoading = false;
    setState(() {});
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Send Email Success'),
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
                emailcontroller.clear();
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.blue,
        title: const Text("Forgot Password Page"),
        actions: const [],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          height: 52,
          child: isLoading
              ? context.showLoading()
              : ButtonWidget(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      doReset(context);
                    }
                  },
                  color: ColorConstant.blue,
                  child: Center(
                    child: Text(
                      "Send E-mail",
                      style: TextStyleConstant.textWhite.copyWith(
                        fontWeight: bold,
                      ),
                    ),
                  ),
                ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/logo-text.png'),
                Text(
                  "E-mail",
                  style: TextStyleConstant.textBlack
                      .copyWith(fontSize: 16.0, fontWeight: bold),
                ),
                TextFormFieldBorderWidget(
                  pleaceholder: 'Your E-Mail',
                  controller: emailcontroller,
                  validator: (value) => Validator.email(value),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
