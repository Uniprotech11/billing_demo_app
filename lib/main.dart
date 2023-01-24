import 'package:android_intent/android_intent.dart';
import 'package:android_intent/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages, unused_import
import 'package:platform/platform.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  TextEditingController typeController = TextEditingController();
  TextEditingController actionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController billController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  // ignore: unnecessary_const
  static const platform = const MethodChannel('com.lululalait.kiosk');

  //   final uri = Uri.parse(settings.name);
  // final route = uri.path;
  // final param = uri.queryParameters['foo'];

  // static bool isAndroid = false;

  Future<void> AndroidCheck() async {
//if (Platform.isAndroid) {
    final AndroidIntent intent = AndroidIntent(
      action: 'com.lululalait.kiosk',
      data: 'com.lululalait.kiosk.KioskActivity',
    );
    await intent.launch();
//}
  }

  void _openExplicitIntentsView(BuildContext context) {
    Navigator.of(context).pushNamed(ExplicitIntentsWidget.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Test Billing APP',
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(children: <Widget>[
                  RichText(
                    text: TextSpan(
                        text: 'Type',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 13),
                        children: [
                          TextSpan(
                              text: ' *',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14))
                        ]),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: typeController,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.bottom,
                      textCapitalization: TextCapitalization.sentences,
                      //  maxLength: 10,
                    ),
                  ),
                ]),
                Row(children: <Widget>[
                  RichText(
                    text: TextSpan(
                        text: 'Action',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 13),
                        children: [
                          TextSpan(
                              text: ' *',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14))
                        ]),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: actionController,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.bottom,
                      textCapitalization: TextCapitalization.sentences,
                      //  maxLength: 10,
                    ),
                  ),
                ]),
                Row(children: <Widget>[
                  Text('Date'),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: dateController,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.bottom,
                      textCapitalization: TextCapitalization.sentences,
                      //  maxLength: 10,
                    ),
                  ),
                ]),
                Row(children: <Widget>[
                  Text('Time'),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: timeController,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.bottom,
                      textCapitalization: TextCapitalization.sentences,
                      //  maxLength: 10,
                    ),
                  ),
                ]),
                Row(children: <Widget>[
                  RichText(
                    text: TextSpan(
                        text: 'Bill ID',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 13),
                        children: [
                          TextSpan(
                              text: ' *',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14))
                        ]),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: billController,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.bottom,
                      textCapitalization: TextCapitalization.sentences,
                      //   maxLength: 10,
                    ),
                  ),
                ]),
                Row(children: <Widget>[
                  RichText(
                    text: TextSpan(
                        text: 'Amount',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 13),
                        children: [
                          TextSpan(
                              text: ' *',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14))
                        ]),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: amountController,
                    ),
                  ),
                ]),
                SizedBox(
                  height: 30,
                ),
                RichText(
                  text: TextSpan(
                      text: '(*)',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.normal,
                          fontSize: 13),
                      children: [
                        TextSpan(
                            text: 'Items marked are mandatory',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14))
                      ]),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text('Please fill the fields mentioned with (*)',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Center(
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(25),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            // width: 35,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.orange, // background
                                onPrimary: Colors.white, // foreground
                              ),
                              child: Text(
                                'Settings',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(25),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            // width: 35,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blueAccent, // background
                                onPrimary: Colors.white, // foreground
                              ),
                              child: Text(
                                'Payment',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              onPressed: () async {
                               // AndroidCheck();
                                var result =
                                    await platform.invokeMethod("sendData", {
                                  "type": "1",
                                  "action": "request",
                                  "date": "",
                                  "time": "",
                                  "bill_id": "113",
                                  "amount": "100"
                                });
                               print(result);

//                                 {
// // "type": "1",
// // "action": "request",
// // "date": "",
// // "time": "",
// // "bill_id": "113",
// // "amount": "10"
//                                 }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExplicitIntentsWidget extends StatelessWidget {
  const ExplicitIntentsWidget();
  // ignore: public_member_api_docs
  static const String routeName = "/explicitIntents";
  void _startActivityInNewTask() {
    final AndroidIntent intent = AndroidIntent(
      action: 'com.lululalait.kiosk',
      // data: Uri.encodeFull('https://flutter.io'),
      package: 'com.lululalait.kiosk.KioskActivity',
      flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
    );
    intent.launch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test explicit intents'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[],
          ),
        ),
      ),
    );
  }
}
