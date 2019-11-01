import 'package:flutter/material.dart';
import 'package:membership_card/all_cards.dart';

import 'add_cards.dart';
import 'card_info.dart';

void main() => runApp(GoWallet());

class GoWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'GoWallet App',
        home: AllCards(),
        routes: <String, WidgetBuilder>{
          "/add" : (BuildContext context) => AddCardPage(),
          "/cardinfo" : (BuildContext context) => CardInfoPage(),
        },
    );
  }
}