import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:membership_card/model/card_model.dart';
import 'package:qrscan/qrscan.dart';
import 'package:qrscan/qrscan.dart' as scanner;
//String cameraScanResult = await scanner.scan();

class ScanPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ScanPageState();
  }
}

class ScanPageState extends State<ScanPage>{
  String barcode = "";
  @override
  // ignore: missing_return
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan barcodes'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(barcode),
            MaterialButton(
              onPressed: scan,
              child: Text("Scan"),
              color: Colors.blue,
              textColor: Colors.white,
            )
          ],
        )
      ),
    );
  }
}

//Future scan() async {
//  try {
//    String barcode = await scanner.scan();
//    setState(() => this.barcode = barcode);
//  } on Exception catch (e) {
//    if (e == scanner.CameraAccessDenied) {
//      setState(() {
//        this.barcode = 'The user did not grant the camera permission!';
//      });
//    } else {
//      setState(() => this.barcode = 'Unknown error: $e');
//    }
//  } on FormatException {
//    setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
//  } catch (e) {
//    setState(() => this.barcode = 'Unknown error: $e');
//  }
//}

