import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// This is the Add_Card Page Class especially for adding one card
/// If user wants to add one card, it needs to go into this page
/// and write some information such as card number and card name to
/// finish the card creating procedure
class AddCardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddCardPageState();
  }
}

class AddCardPageState extends State<AddCardPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        //Todo: Add more UI for App bar
      ),
      //Todo: Add more UI and interaction for this Add_Card Page
    );
  }
}