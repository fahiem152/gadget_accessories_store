import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:projecttas_223200007/shared/colors/colors.dart';
import 'package:projecttas_223200007/shared/indicator/indicator.dart';
import 'package:projecttas_223200007/shared/textstyle/textstyle.dart';
import 'package:projecttas_223200007/shared/validator/validator.dart';
import 'package:projecttas_223200007/shared/widgets/button_widget.dart';
import 'package:projecttas_223200007/shared/widgets/textformfield_border_widget.dart';
import 'package:projecttas_223200007/data/datasources/firebase_datasource/firebase_datasource.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    oldPassword.dispose();
    newPassword.dispose();
    super.dispose();
  }

  doChangePassword() async {
    isLoading = true;
    setState(() {});
    final result = await FirebaseDatasource()
        .changePassword(oldPassword.text, newPassword.text);
    if (result.contains('Successfully')) {
      context.showSnackBarSuccess(result);
      Navigator.pop(context);
    } else if (result.contains('No user found')) {
      context.showSnackBarError(result);
    } else if (result.contains('Wrong password')) {
      context.showSnackBarError(result);
    } else if (result.contains('Error:')) {
      context.showSnackBarError(result);
    } else {
      context.showSnackBarError(result);
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.blue,
        title: const Text("Chaneg Password Page"),
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
                    if (formKey.currentState!.validate()) {
                      doChangePassword();
                      log("Running Loasing: $isLoading");
                    }
                  },
                  color: ColorConstant.blue,
                  child: Center(
                    child: Text(
                      "Change Password",
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
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Old Password",
                  style: TextStyleConstant.textBlack.copyWith(
                    fontWeight: bold,
                  ),
                ),
                TextFormFieldBorderWidget(
                  pleaceholder: 'Old Password',
                  controller: oldPassword,
                  validator: (value) => Validator.password(value),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  "New Password",
                  style: TextStyleConstant.textBlack.copyWith(
                    fontWeight: bold,
                  ),
                ),
                TextFormFieldBorderWidget(
                  pleaceholder: 'New Password',
                  controller: newPassword,
                  validator: (value) => Validator.password(value),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
