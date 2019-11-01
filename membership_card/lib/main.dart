import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:membership_card/pages/all_cards.dart';
import 'package:membership_card/model/card_count.dart';
import 'package:provider/provider.dart';

import 'model/card.dart';
import 'pages/add_cards.dart';
import 'pages/card_info.dart';

void main() => runApp(GoWallet());

/// This is the entrance of our GoWallet App.
/// It is used for entering the whole GoWallet App and
///  all the routes are set here.
/// Maybe in the future we need to do the state management here.
///  if the state changed so quickly that we have to do the
///  global state management
class GoWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      // This is the providers for out state management
      providers: [
        ChangeNotifierProvider(
          builder: (context) => CardCounter()
        ),
        ChangeNotifierProvider(
          builder: (context) => CardInfo(),
        )
      ],
      child: MaterialApp(
        title: 'GoWallet App',
        home: AllCards(),

        // routes defined all the page routes of our App
        routes: {
          "/add" : (BuildContext context) => AddCardPage(),
          "/cardinfo" : (BuildContext context) => CardInfoPage(),
        },
      )
    );
  }
}