import 'dart:async';
import 'dart:convert';
//import 'dart:html';
import 'package:flutter/material.dart';
//import 'package:flushbar/flushbar.dart';

import 'package:flutter/services.dart';
import 'APIServices/APIInterface.dart';
import 'Models/PaymentResponse.dart';
import 'Models/SavePaymentResponse.dart';
import 'Request.dart';
import 'package:logger/logger.dart';

import 'ViewPaymentDetails.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Billing APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Billing APP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  TextEditingController typeController = TextEditingController();
  TextEditingController actionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController billController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  late PaymentResponse paymentResponseModel;
  late SavePaymentResponse savePaymentResponse;
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late Map<String, dynamic> paymentResponse;
  static const platform = MethodChannel('payment');
  @override
  void initState() {
    platform.setMethodCallHandler(_receiveFromHost);
    super.initState();
  }

  showUserSnak(String msg, bool flag) {
  (SnackBar(
      content: Text(
        msg,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      backgroundColor: (flag) ? Colors.black54 : Colors.red,
      duration: Duration(seconds: 2),
    ));
  }
  // showFlushbarMessage(String msg, bool flag) {
  //   Flushbar(
  //     message: msg,
  //     titleText: Text(
  //       msg,
  //       style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
  //     ),
  //     backgroundColor: (flag) ? Colors.black54 : Colors.red,
  //     duration: Duration(seconds: 2),
  //   ).show(context);
  // }

  Future<void> _receiveFromHost(MethodCall call) async {
    try {
      if (call.method == "response") {
        logger.d("response on init: ${call.arguments}");
        //List<dynamic> response = call.arguments;
        // Map<String, dynamic> response = call.arguments;
        Map<String, dynamic> response;
        String jsonString = call.arguments;
        try {
          response = json.decode(jsonString);
          print("Response: $response");
        } catch (e) {
          throw Exception("Error while decoding the JSON response: $e");
        }
        paymentResponseModel = PaymentResponse.fromJson(response);
        // Map<String, dynamic> response =
        //     Map<String, dynamic>.from(call.arguments);
        // PaymentResponse paymentResponseModel =
        //     PaymentResponse.fromJson(response);
        print("PaymentResponse object: ${paymentResponseModel}");
        // logger.d("PaymentResponse:$paymentResponseModel.billId");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Payment Response'),
              content: Text('Payment status: ${response.toString()}'),
              actions: <Widget>[
                ElevatedButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    typeController.clear();
                    actionController.clear();
                    billController.clear();
                    amountController.clear();
                  },
                ),
              ],
            );
          },
        );
        var r = PaymentResponse.fromJson(response);
        String jsonString1 = jsonEncode(r.toJson());
        print('Payment Encode:${jsonString1}');
        // savePaymentResponse =
        //     SavePaymentResponse.fromJson(paymentResponseModel.toJson());
        // savePaymentResponse.atmId = paymentResponseModel.atmId;
        // savePaymentResponse.action = paymentResponseModel.action;
        // savePaymentResponse.amount = paymentResponseModel.amount;
        // savePaymentResponse.billId = paymentResponseModel.billId;
        // savePaymentResponse.date = paymentResponseModel.date;
        // savePaymentResponse.paymethod = paymentResponseModel.paymethod;
        // savePaymentResponse.responseMessage =
        //     paymentResponseModel.responseMessage;
        // savePaymentResponse.time = paymentResponseModel.time;
        // savePaymentResponse.transactionId = paymentResponseModel.transactionId;
        // savePaymentResponse.type = paymentResponseModel.type;
        // savePaymentResponse.upiApprovalCode =
        //     paymentResponseModel.upiApprovalCode;
        // savePaymentResponse.upiDate = paymentResponseModel.upiDate;
        // savePaymentResponse.upiMid = paymentResponseModel.upiMid;
        // savePaymentResponse.upiResponseMessage =
        //     paymentResponseModel.upiResponseMessage;
        // savePaymentResponse.upiTime = paymentResponseModel.upiTime;
        // savePaymentResponse.upiTransactionId =
        //     paymentResponseModel.upiTransactionId;
        // print("Save Response:${savePaymentResponse.toJson()}");

        Map<String, dynamic> jsonMap = r.toJson();
        String jsonSave = jsonEncode(jsonMap);
        savePaymentResponseAPI(context, paymentResponseModel.toJson());
        print('Save Json Code::${jsonString1}');
      }
    } on PlatformException catch (error) {
      print("Error in _receiveFromHost: $error");
    }

    setState(() {});
  }

  void createIntent() async {
    Request request = Request(
        type: typeController.text.toString(),
        action: actionController.text.toString(),
        date: "",
        time: "",
        billId: billController.text.toString(),
        amount: amountController.text.toString());
    String salesRequest = jsonEncode(request);
    Future<void> _sales() async {
      try {
        logger.d("start sales");
        await platform.invokeMethod('sales', salesRequest);
      } catch (e) {
        logger.d("error: $e");
      }
    }

    _sales.call();
  }

  void showResponseDialog(PaymentResponse data) {
    print('Bill ID' + data.billId);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Response'),
          // content: Text('Payment status: ${response['status']}'),
          content: Text('Payment status:' + data.billId),
          actions: <Widget>[
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                typeController.clear();
                actionController.clear();
                billController.clear();
                amountController.clear();
              },
            ),
          ],
        );
      },
    );
  }

  savePaymentResponseAPI(BuildContext context, passJson) async {
    // AppUtils.showProgressDialog(context, "Please Wait...");
    var vStatus = await ApiInterface().savePaymentResponse(passJson);
    if ((vStatus.toString() != 'null')) {
      // If the call to the server was successful, parse the JSON
      Future.delayed(Duration(milliseconds: 1)).then((value) async {
        List<dynamic> list = [json.decode(vStatus!)];
        //   Navigator.pop(context);
        if (list[0]['status'].toString() == 'true') {
          setState(() {
            print('Save Payment Response API:${passJson}');
          });
        
          showUserSnak("Payment Saved Successfully", true);
        } else {
          showUserSnak("Something went wrong", false);
        }
      });
    } else {
      Future.delayed(Duration(milliseconds: 1)).then((value) {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     key: _scaffoldKey,
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
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          //margin: EdgeInsets.all(25),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.13,
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
                          margin: EdgeInsets.all(15),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.13,
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
                              onPressed: () {
                                createIntent();
                              },
                            ),
                          ),
                        ),
                        Container(
                          //  margin: EdgeInsets.all(25),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.13,
                            // width: 35,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.pinkAccent, // background
                                onPrimary: Colors.white, // foreground
                              ),
                              child: Text(
                                'View',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ViewPaymentDetails()));
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

// class PaymentDetails extends StatefulWidget {
//   @override
//   _PaymentDetailsState createState() => _PaymentDetailsState();
// }

// class _PaymentDetailsState extends State<PaymentDetails> {
//   late Map<String, dynamic> paymentResponse;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: paymentResponse == null
//           ? Text("No response yet")
//           : Text("Response: ${paymentResponse.toString()}"),
//     );
//   }
// }
