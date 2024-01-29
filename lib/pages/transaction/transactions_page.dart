// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:projecttas_223200007/data/datasources/firebase_datasource/firebase_datasource.dart';
import 'package:projecttas_223200007/data/models/transaction_model.dart';
import 'package:projecttas_223200007/pages/transaction/detail_transaction_page.dart';
import 'package:projecttas_223200007/shared/colors/colors.dart';
import 'package:projecttas_223200007/shared/textstyle/textstyle.dart';
import 'package:projecttas_223200007/shared/utils/auth_utils.dart';
import 'package:projecttas_223200007/shared/widgets/card_transaction_widget.dart';

class TransactionsPage extends StatelessWidget {
  final bool isAdmin;
  const TransactionsPage({
    Key? key,
    required this.isAdmin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 24.0,
        ),
        Text(
          "Transactions Page",
          style: TextStyleConstant.textBlack.copyWith(
            fontSize: 20.0,
            fontWeight: bold,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Expanded(
          child: StreamBuilder<List<TransactionModel>>(
            stream: isAdmin
                ? FirebaseDatasource().getTransactions()
                : FirebaseDatasource().getTransactionsByUid(
                    AuthUtils.getCurrentUserID() ?? "no-uid"),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: ColorConstant.blue,
                  ),
                );
              }

              List<TransactionModel> transactions = snapshot.data ?? [];
              if (transactions.isEmpty) {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    "There is no transaction history at the moment. Start shopping now to enjoy our services,",
                    style: TextStyleConstant.textBlack.copyWith(
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ));
              }
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: transactions.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  final transaction = transactions[index];
                  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                      transaction.transactionTime);
                  return CardTransactionWidget(
                    transaction: transaction,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailTransactionPage(
                            transaction: transaction,
                            dateTime: dateTime,
                            isAdmin: isAdmin,
                          ),
                        ),
                      );
                    },
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
    );
  }
}
