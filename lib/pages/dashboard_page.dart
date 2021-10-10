import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:moneylend/controllers/controllers.dart';
import 'package:moneylend/models/models.dart';

List<TransactionItemModel> history = [
  TransactionItemModel(
    id: '1',
    title: 'Celular',
    amount: 200,
    date: DateTime.now(),
    type: TransactionType.lend,
    photoUrl:
        'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
  ),
  TransactionItemModel(
    id: '1',
    title: 'Celular',
    amount: 100,
    date: DateTime.now(),
    type: TransactionType.pay,
    photoUrl:
        'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
  ),
];

class DashboardPage extends StatelessWidget {
  DashboardPage({
    Key? key,
  }) : super(key: key);

  final _transactionController = TransactionController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1b1c5b),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const _TotalDebitCard(),
            const Text("Nova transação"),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _ActionTransactionButton(
                      transactionController: _transactionController,
                      type: TransactionType.lend,
                    ),
                  ),
                  Expanded(
                    child: _ActionTransactionButton(
                      transactionController: _transactionController,
                      type: TransactionType.pay,
                    ),
                  ),
                ],
              ),
            ),
            const Text("Histórico"),
            Expanded(
              child: ListView.separated(
                itemCount: history.length,
                itemBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 50.0,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return _TransactionItem(
                    transaction: history[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionTransactionButton extends StatelessWidget {
  const _ActionTransactionButton({
    Key? key,
    required this.transactionController,
    required this.type,
  }) : super(key: key);

  final TransactionController transactionController;
  final TransactionType type;

  static const buttonColors = {
    TransactionType.lend: Colors.greenAccent,
    TransactionType.pay: Colors.redAccent,
  };

  static const shadowColors = {
    TransactionType.lend: Colors.green,
    TransactionType.pay: Colors.red,
  };

  static const buttonTexts = {
    TransactionType.lend: 'Pagar',
    TransactionType.pay: 'Receber',
  };

  @override
  Widget build(BuildContext context) {
    final actionText = buttonTexts[type]!;
    final buttonColor = buttonColors[type] ?? Theme.of(context).primaryColor;
    final shadowColor = shadowColors[type] ?? Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: () {
        transactionController.navigateToNewTransaction(
          context,
          TransactionType.pay,
        );
      },
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            color: buttonColor,
            child: Text(actionText),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                  offset: const Offset(0.0, 1.0),
                ),
              ],
            ),
            child: const Icon(Icons.money),
          ),
        ],
      ),
    );
  }
}

class _TotalDebitCard extends StatelessWidget {
  const _TotalDebitCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.0,
      color: const Color(0xfff9f0ff),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'R\$ 0,00',
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Total devido",
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  const _TransactionItem({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  final TransactionItemModel transaction;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 14.0,
      ),
      decoration: BoxDecoration(
        color: const Color(0xfffaece1),
        borderRadius: BorderRadius.circular(24.0), // not circular
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              color: const Color(0xff1b1c5b),
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(transaction.photoUrl),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1b1c5b),
                    ),
                  ),
                  Text(
                    DateFormat.yMd().format(DateTime.now()),
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Color(0xff1b1c5b),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            "R\$ ${transaction.amount},00",
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xff1b1c5b),
            ),
          ),
        ],
      ),
    );
  }
}
