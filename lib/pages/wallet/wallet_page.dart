// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:projecttas_223200007/data/datasources/firebase_datasource/firebase_datasource.dart';
import 'package:projecttas_223200007/data/datasources/stripe/stripe_datasource.dart';
import 'package:projecttas_223200007/data/models/top_up_model.dart';
import 'package:projecttas_223200007/data/models/user_model.dart';
import 'package:projecttas_223200007/shared/colors/colors.dart';
import 'package:projecttas_223200007/shared/textstyle/textstyle.dart';
import 'package:projecttas_223200007/shared/validator/validator.dart';
import 'package:projecttas_223200007/shared/widgets/button_widget.dart';
import 'package:projecttas_223200007/shared/widgets/card_item_topup_widget.dart';
import 'package:projecttas_223200007/shared/widgets/card_wallet_widget.dart';
import 'package:projecttas_223200007/shared/widgets/textformfield_border_widget.dart';

class WalletPage extends StatefulWidget {
  final bool isAdmin;
  const WalletPage({
    Key? key,
    required this.isAdmin,
  }) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController balanceController = TextEditingController();
  Map<String, dynamic>? paymentIntent;
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  loadUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    userModel = await FirebaseDatasource().getUserByUid(uid: user!.uid);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: userModel == null
          ? Center(
              child: CircularProgressIndicator(
                color: ColorConstant.blue,
              ),
            )
          : Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.isAdmin
                        ? SizedBox()
                        : Center(
                            child: Text(
                              "Wallet Page",
                              style: TextStyleConstant.textBlack.copyWith(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                    widget.isAdmin
                        ? SizedBox()
                        : const SizedBox(
                            height: 20.0,
                          ),
                    widget.isAdmin
                        ? SizedBox()
                        : CardWalletWidget(user: userModel!),
                    const SizedBox(
                      height: 12.0,
                    ),
                    widget.isAdmin
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: 20.0,
                              ),
                              child: Text(
                                "Recent Top Up",
                                style: TextStyleConstant.textBlack.copyWith(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        : Text(
                            "Recent Top Up",
                            style: TextStyleConstant.textBlack.copyWith(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    Expanded(
                      child: StreamBuilder<List<TopUpModel>>(
                        stream: widget.isAdmin
                            ? FirebaseDatasource().getTopUps()
                            : FirebaseDatasource()
                                .getTopUpByUid(userModel!.uid),
                        builder: (context, snapshot) {
                          log('Running snapshot: ${snapshot.data}');
                          if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: ColorConstant.blue,
                              ),
                            );
                          }

                          List<TopUpModel> topUps = snapshot.data ?? [];
                          log('Running topUps: $topUps');
                          if (topUps.isEmpty) {
                            return Center(
                                child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Text(
                                "There is no top-up history at the moment. Start topping up now to enjoy our services.",
                                style: TextStyleConstant.textBlack.copyWith(
                                  fontSize: 14.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ));
                          }
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: topUps.length,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              final topUp = topUps[index];

                              return CardItemTopupWidget(
                                topUp: topUp,
                                isAdmin: widget.isAdmin,
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                  ],
                ),
                widget.isAdmin
                    ? SizedBox()
                    : Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: 52,
                          child: ButtonWidget(
                            onPressed: () async {
                              await showDialog<void>(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Top Up+',
                                      style: TextStyleConstant.textBlue,
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Form(
                                            key: formKey,
                                            child: TextFormFieldBorderWidget(
                                              controller: balanceController,
                                              pleaceholder: "Rp. 10.000",
                                              validator: (value) =>
                                                  Validator.priceMinimun(
                                                      value, '10000'),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 24.0,
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              text: 'Note*: ',
                                              style: TextStyleConstant.textBlack
                                                  .copyWith(
                                                      fontSize: 12.0,
                                                      fontWeight: bold),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text:
                                                      'Top-up amount must be at least Rp. 10,000',
                                                  style: TextStyleConstant
                                                      .textBlack
                                                      .copyWith(
                                                    fontSize: 12.0,
                                                    fontWeight: reguler,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ButtonWidget(
                                              onPressed: () {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  makePayment(balanceController
                                                          .text)
                                                      .whenComplete(() {
                                                    Navigator.pop(context);
                                                  });
                                                }
                                              },
                                              color: ColorConstant.blue,
                                              child: Center(
                                                child: Text(
                                                  "Top Up",
                                                  style: TextStyleConstant
                                                      .textWhite
                                                      .copyWith(
                                                    fontWeight: bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ButtonWidget(
                                              onPressed: () {
                                                balanceController.clear();
                                                Navigator.pop(context);
                                              },
                                              color: ColorConstant.red,
                                              child: Center(
                                                  child: Text(
                                                "Cancel",
                                                style:
                                                    TextStyleConstant.textWhite,
                                              )),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            color: ColorConstant.blue,
                            child: Center(
                              child: Text(
                                "Top Up +",
                                style: TextStyleConstant.textWhite.copyWith(
                                  fontSize: 14.0,
                                  fontWeight: bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      paymentIntent =
          await StripeDatasource().createPaymentIntent(amount, 'IDR');

      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],

                  // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
                  // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Gadget Accessories Store'))
          .then((value) {});

      displayPaymentSheet(amount);
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        final model = TopUpModel(
          uid: '0',
          timestamp: 0,
          amount: int.parse(balanceController.text),
          status: "Succsess",
          userUid: userModel!.uid,
          userName: userModel!.name,
        );
        final result = await FirebaseDatasource().addTopUp(model);

        if (result) {
          final resultUpdateBalanceUser = await FirebaseDatasource()
              .updateBalanceUser(userModel!, int.parse(balanceController.text),
                  isTopUp: true);
          if (resultUpdateBalanceUser) {
            showDialog(
                context: context,
                builder: (_) => const AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),
                              Text("Payment Successfull"),
                            ],
                          ),
                        ],
                      ),
                    ));
            loadUser();
            balanceController.clear();
          } else {
            log('Error Failed User Balance Upate');
          }
        } else {
          log('Error Failed Add Top Up');
        }

        paymentIntent = null;
      }).onError((error, stackTrace) {
        log('onError is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      log('StripeException Error  is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      log('$e');
    }
  }
}
