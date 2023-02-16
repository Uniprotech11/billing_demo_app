import 'dart:convert';
import 'package:billing_app_new1/PaymentDetails.dart';
import 'package:billing_app_new1/main.dart';
import 'package:flutter/material.dart';
import 'APIServices/APIInterface.dart';
import 'Models/PaymentResponse.dart';



class ViewPaymentDetails extends StatefulWidget {
  @override
  _ViewPaymentDetailsState createState() => _ViewPaymentDetailsState();
}

class _ViewPaymentDetailsState extends State<ViewPaymentDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
late List<PaymentResponse> paymentResponse;



  List<Datum> paymentdetails = [];



  @override
  void initState() {
    super.initState();
    _loadInitial();
  } 

  _loadInitial() async {
    setState(() { 
     // getdetailsApi(context);  
    });
  }


  // showUserSnak(String msg, bool flag) {
  //   _scaffoldKey.currentState.showSnackBar(SnackBar(
  //     content: Text(
  //       msg,
  //       style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
  //     ),
  //     backgroundColor: (flag) ? Colors.green[700] : Colors.red[700],
  //     duration: Duration(seconds: 2),
  //   ));
  // }

  
  //   late PaymentDetailsList userData =
  //     new PaymentDetailsList(status: false, message: '', data: []);
  // getdetailsApi(context) async {
    
  //   var vStatus = await ApiInterface().getPaymentetails();
  //   if ((vStatus.toString() != 'null')) {
  //     Future.delayed(Duration(milliseconds: 1)).then((value) {
  //       setState(() {
  //         List<dynamic> list = [json.decode(vStatus!)];
  //         // Navigator.pop(context);
  //         if (list[0]['status'] == true) {
  //           userData = PaymentDetailsList.fromJson(json.decode(vStatus));
  //         } else {
  //           showUserSnak(list[0]['message'].toString(), false);
  //         }
  //       });
  //     });
  //   } else {
  //     Future.delayed(Duration(milliseconds: 1)).then((value) {
  //       // Navigator.pop(context);
  //       showUserSnak("Internal Server Error", false);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 50,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
    
        title: Padding(
          padding: const EdgeInsets.only(right: 0.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Payment Details",
              style: TextStyle(
                  fontSize: 22,
                  color: Color(0xFF0091D4),
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[          

              Container(
                height: 50,
                margin: const EdgeInsets.only(top: 16),
                color: Colors.grey[100],
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                          color: Colors.blue,
                          child: Center(
                              child: Text('Bill ID'.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)))),
                    ),
                    Expanded(
                        child: Container(
                            color: Colors.blue,
                            child: Center(
                                child: Text('Amount'.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))))),
                    Expanded(
                        child: Container(
                            color: Colors.blue,
                            child: Center(
                                child: Text('Transaction ID'.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))))),
                    Expanded(
                        child: Container(
                            color: Colors.blue,
                            child: Center(
                                child: Text('Paymethod'.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))))),
                  ],
                ),
              ),
              Container(
                child: paymentdetails.length == 0
                    ? Center(
                        child: Padding(
                        padding: const EdgeInsets.only(bottom: 100.0),
                        child: Text(
                          paymentdetails.length == 0
                              ? ''
                              : "${(('No data found'))}",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ))
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: paymentResponse.length,
                        itemBuilder: (BuildContext context, int index) {
                          return PaymentDetails(
                              context, index, paymentdetails);
                        }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget PaymentDetails(
      BuildContext context, int index, List<Datum> paymentResponse) {
    return InkWell(    
      child: Container(
        height: 60,
        child: Card(
          elevation: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        margin: EdgeInsets.only(right: 50, top: 10),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            paymentResponse[index].billId,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontFamily: 'ubuntu',
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.black45,
                    height: 50,
                    width: 1,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        margin: EdgeInsets.only(right: 50, top: 10),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            paymentResponse[index].amount,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontFamily: 'ubuntu',
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.black45,
                    height: 50,
                    width: 1,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        margin: EdgeInsets.only(right: 50, top: 10),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            paymentResponse[index].transactionId.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontFamily: 'ubuntu',
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.black45,
                    height: 50,
                    width: 1,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        margin: EdgeInsets.only(right: 50, top: 10),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                             paymentResponse[index].paymethod,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontFamily: 'ubuntu',
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.black45,
                    height: 50,
                    width: 1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }  
}
