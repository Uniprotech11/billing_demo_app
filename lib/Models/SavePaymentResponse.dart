// To parse this JSON data, do
//
//     final savePaymentResponse = savePaymentResponseFromJson(jsonString);

import 'dart:convert';

SavePaymentResponse savePaymentResponseFromJson(String str) => SavePaymentResponse.fromJson(json.decode(str));

String savePaymentResponseToJson(SavePaymentResponse data) => json.encode(data.toJson());

class SavePaymentResponse {
    SavePaymentResponse({
        required this.atmId,
        required this.action,
        required this.amount,
        required this.billId,
        required this.date,
        required this.paymethod,
        required this.responseMessage,
        required this.time,
        required this.transactionId,
        required this.type,
        required this.upiApprovalCode,
        required this.upiDate,
        required this.upiMid,
        required this.upiResponseMessage,
        required this.upiTime,
        required this.upiTransactionId,
    });

    String atmId;
    String action;
    String amount;
    String billId;
    DateTime date;
    String paymethod;
    String responseMessage;
    DateTime time;
    String transactionId;
    String type;
    String upiApprovalCode;
    DateTime upiDate;
    String upiMid;
    String upiResponseMessage;
    DateTime upiTime;
    String upiTransactionId;

    factory SavePaymentResponse.fromJson(Map<String, dynamic> json) => SavePaymentResponse(
        atmId: json["atm_id"],
        action: json["action"],
        amount: json["amount"],
        billId: json["bill_id"],
        date: DateTime.parse(json["date"]),
        paymethod: json["paymethod"],
        responseMessage: json["response_message"],
        time: DateTime.parse(json["time"]),
        transactionId: json["transaction_id"],
        type: json["type"],
        upiApprovalCode: json["upi_approval_code"],
        upiDate: DateTime.parse(json["upi_date"]),
        upiMid: json["upi_mid"],
        upiResponseMessage: json["upi_response_message"],
        upiTime: DateTime.parse(json["upi_time"]),
        upiTransactionId: json["upi_transaction_id"],
    );

    Map<String, dynamic> toJson() => {
        "atm_id": atmId,
        "action": action,
        "amount": amount,
        "bill_id": billId,
        "date": date.toIso8601String(),
        "paymethod": paymethod,
        "response_message": responseMessage,
        "time": time.toIso8601String(),
        "transaction_id": transactionId,
        "type": type,
        "upi_approval_code": upiApprovalCode,
        "upi_date": upiDate.toIso8601String(),
        "upi_mid": upiMid,
        "upi_response_message": upiResponseMessage,
        "upi_time": upiTime.toIso8601String(),
        "upi_transaction_id": upiTransactionId,
    };
}
