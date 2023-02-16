import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;

class GlobalVariables {
  static String appStoreID = "UPS";
  static String baseURL = "";
}

class ApiInterface {
  String base_url = "http://192.168.1.250/api/";
  static String username = 'unipro';
  static String password = 'ups@123';

  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));

  // Future<String?> savePaymentResponse(jsonResponse) async {
  //   String url = base_url + 'PaymentResponseSave?User';
  //   print("End url" + url);
  //   try {
  //     var urls = Uri.parse(url);
  //     var future = http.post(
  //       urls,
  //       headers: <String, String>{
  //         "Content-Type": "application/json",
  //         'authorization': basicAuth,
  //         "Access-Control-Allow-Origin": "*"
  //       },
  //     );
  //     var response = await future;
  //     if (response.statusCode == 200) {
  //       return response.body;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  // }

  Future<String?> savePaymentResponse(jsonResponse) async {
    String url = base_url + 'PaymentResponseSave?User';

    print("End url " + url);
    try {
      //encode Map to JSON
      var body = json.encode(jsonResponse);
      print(body);
      var urls = Uri.parse(url);
      var future = http.post(urls,
          headers: <String, String>{'authorization': basicAuth}, body: body);
      var response = await future;
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String?> getPaymentetails() async {
    String url = base_url + '/PaymentResponseSave';
    print("End url " + url);
    try {
      var uri = Uri.parse(url);
      var future = http.get(
        uri,
        headers: <String, String>{'authorization': basicAuth},
      );
      var response = await future;
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
