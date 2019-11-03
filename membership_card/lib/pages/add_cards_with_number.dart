import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:membership_card/model/card_count.dart';
import 'package:membership_card/model/card_model.dart';
import 'package:provider/provider.dart';

class AddCardWithNumberPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddCardWithNumberPageState();
}

class AddCardWithNumberPageState extends State<AddCardWithNumberPage> {

  //card control
  var cardController = TextEditingController();

  //card type control
  var cardTypeController = TextEditingController();
  //Todo: Missing Remark Controller because every card has a remark attr

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          // card input
          TextField(
            controller: cardController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              icon: Icon(Icons.credit_card),
              labelText: 'Please enter you cardID',
            ),
            autofocus: false,
          ),
          //card type input
          TextField(
            controller: cardTypeController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              icon: Icon(Icons.calendar_view_day),
              labelText: 'Please enter your cardtype',
            ),
            autofocus: false,),
          Consumer<CardCounter>(
            builder: (context, counter, child) => RaisedButton(
              onPressed: () {
                Navigator.pop(context);
                counter.addCard(CardInfo(
                  cardController.value.text,
                  cardTypeController.value.text,
                  //Todo: Lost remark controller
                ));
              },
              child: Text('Add and return'),
            ),
          ),
        ],
      ),
    );
  }
}