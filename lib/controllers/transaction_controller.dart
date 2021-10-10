import 'package:flutter/material.dart';
import 'package:moneylend/models/transaction_item_model.dart';
import 'package:moneylend/pages/pages.dart';

class TransactionController {
  void navigateToNewTransaction(
    BuildContext context,
    TransactionType transactionType,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewTransactionPage(
          transactionType: transactionType,
        ),
      ),
    );
  }
}
