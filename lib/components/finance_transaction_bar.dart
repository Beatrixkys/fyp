import 'package:flutter/material.dart';
import 'package:fyp/components/buttons.dart';
import 'package:fyp/components/cards.dart';
import 'package:fyp/constant.dart';

class TransactionBar extends StatelessWidget {
  const TransactionBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: 400,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            FinanceButton(
                bgColor: kCream,
                btnColor: Colors.black54,
                icon: Icons.add_outlined),
            FinancialCard(
                icon: "assets/add.png", title: "Income", route: '/finance'),
            FinancialCard(
                icon: "assets/minus.png", title: "Expense", route: '/home'),
            FinancialCard(
                icon: "assets/transfer.png",
                title: "Transfer",
                route: '/transferPage'),
          ],
        ),
      ),
    );
  }
}
