// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:projecttas_223200007/data/datasources/firebase_datasource/firebase_datasource.dart';

import 'package:projecttas_223200007/data/models/transaction_model.dart';
import 'package:projecttas_223200007/data/models/user_model.dart';
import 'package:projecttas_223200007/data/service/invoice/invoice_helper.dart';
import 'package:projecttas_223200007/data/service/invoice/invoice_pdf_service.dart';
import 'package:projecttas_223200007/data/service/permession.dart';
import 'package:projecttas_223200007/shared/colors/colors.dart';
import 'package:projecttas_223200007/shared/formatter/formatter.dart';
import 'package:projecttas_223200007/shared/indicator/indicator.dart';
import 'package:projecttas_223200007/shared/textstyle/textstyle.dart';
import 'package:projecttas_223200007/shared/widgets/card_item_transaction_widget.dart';
import 'package:projecttas_223200007/shared/widgets/card_payment_method_widget.dart';
import 'package:projecttas_223200007/shared/widgets/card_user_information.dart';

class DetailTransactionPage extends StatefulWidget {
  final bool? isAdmin;
  final DateTime dateTime;
  final TransactionModel transaction;
  const DetailTransactionPage({
    Key? key,
    this.isAdmin = false,
    required this.dateTime,
    required this.transaction,
  }) : super(key: key);

  @override
  State<DetailTransactionPage> createState() => _DetailTransactionPageState();
}

class _DetailTransactionPageState extends State<DetailTransactionPage> {
  UserModel? user;
  @override
  void initState() {
    super.initState();
    doGetUser();
  }

  doGetUser() async {
    final result =
        await FirebaseDatasource().getUserByUid(uid: widget.transaction.uid);
    user = result;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<int> productQuantity =
        widget.transaction.items.map((e) => e['quantity'] as int).toList();
    int totalQuantityProduct = productQuantity.fold(
        0, (previousValue, element) => previousValue + element);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstant.blue,
          title: Text(
            "Detail Transaction Page",
            style: TextStyleConstant.textWhite,
          ),
          actions: const [],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 30, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Products",
                      style: TextStyleConstant.textBlack.copyWith(
                        fontSize: 16.0,
                        fontWeight: bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final status = await checkPermission();
                        if (status.isGranted) {
                          final pdfFile =
                              await HelperInvoice.generate(widget.transaction);
                          log("pdfFile: $pdfFile");
                          HelperPdfService.openFile(pdfFile);
                        }
                      },
                      child: Row(
                        children: [
                          Text(
                            "Invoice",
                            style: TextStyleConstant.textBlue.copyWith(
                              fontSize: 16.0,
                              fontWeight: medium,
                            ),
                          ),
                          Icon(
                            Icons.download_outlined,
                            color: ColorConstant.blue,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: widget.transaction.items.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return CardItemTransactionWidget(
                    date: widget.dateTime,
                    item: widget.transaction.items[index],
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 16),
                child: Text(
                  "Payment Method",
                  style: TextStyleConstant.textBlack.copyWith(
                    fontSize: 16.0,
                    fontWeight: bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              CardPaymentMethodWidget(
                  payment: widget.transaction.paymentMethod),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 16),
                child: Text(
                  "Payment",
                  style: TextStyleConstant.textBlack.copyWith(
                    fontSize: 16.0,
                    fontWeight: bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(12.0),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                  color: ColorConstant.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 24,
                      offset: Offset(0, 11),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "Total Price ($totalQuantityProduct Product)",
                            style: TextStyleConstant.textBlack,
                          ),
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          Formatter.formatRupiah(
                              int.parse(widget.transaction.subtotal)),
                          style: TextStyleConstant.textBlack.copyWith(
                            fontWeight: bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "Admin Fee",
                            style: TextStyleConstant.textBlack,
                          ),
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          Formatter.formatRupiah(3000),
                          style: TextStyleConstant.textBlack.copyWith(
                            fontWeight: bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Divider(
                      color: ColorConstant.black3,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text("Total Payment",
                              style: TextStyleConstant.textBlack.copyWith(
                                fontSize: 16.0,
                                fontWeight: medium,
                              )),
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          Formatter.formatRupiah(
                              int.parse(widget.transaction.total)),
                          style: TextStyleConstant.textBlack.copyWith(
                            fontWeight: bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              widget.isAdmin!
                  ? user == null
                      ? context.showLoading()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, top: 16),
                              child: Text(
                                "User Information",
                                style: TextStyleConstant.textBlack.copyWith(
                                  fontSize: 16.0,
                                  fontWeight: bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            CardUserInformation(
                              user: user!,
                            ),
                          ],
                        )
                  : const SizedBox(),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ));
  }
}
