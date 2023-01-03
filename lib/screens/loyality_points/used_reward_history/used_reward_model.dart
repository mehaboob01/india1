// To parse this JSON data, do
//
//     final usedPointsHistoryModel = usedPointsHistoryModelFromJson(jsonString);

import 'dart:convert';

UsedPointsHistoryModel usedPointsHistoryModelFromJson(String str) => UsedPointsHistoryModel.fromJson(json.decode(str));

String usedPointsHistoryModelToJson(UsedPointsHistoryModel data) => json.encode(data.toJson());

class UsedPointsHistoryModel {
  UsedPointsHistoryModel({
    this.data,
    this.status,
  });

  Data? data;
  Status? status;

  factory UsedPointsHistoryModel.fromJson(Map<String, dynamic> json) => UsedPointsHistoryModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data!.toJson(),
    "status": status == null ? null : status!.toJson(),
  };
}

class Data {
  Data({
    this.nextToken,
    this.previousToken,
    this.transactions,
  });

  String? nextToken;
  String? previousToken;
  List<Transaction>? transactions;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    nextToken: json["nextToken"] == null ? null : json["nextToken"],
    previousToken: json["previousToken"] == null ? null : json["previousToken"],
    transactions: json["transactions"] == null ? null : List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "nextToken": nextToken == null ? null : nextToken,
    "previousToken": previousToken == null ? null : previousToken,
    "transactions": transactions == null ? null : List<dynamic>.from(transactions!.map((x) => x.toJson())),
  };
}

class Transaction {
  Transaction({
    this.id,
    this.points,
    this.date,
    this.typeId,
    this.amount,
    this.accountOrMobileNumber,
    this.pointsMultiplier,
  });

  String? id;
  int? points;
  String? date;
  String? typeId;
  int? amount;
  String? accountOrMobileNumber;
  int? pointsMultiplier;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json["id"] == null ? null : json["id"],
    points: json["points"] == null ? null : json["points"],
    date: json["date"] == null ? null : json["date"],
    typeId: json["typeId"] == null ? null : json["typeId"],
    amount: json["amount"] == null ? null : json["amount"],
    accountOrMobileNumber: json["accountOrMobileNumber"] == null ? null : json["accountOrMobileNumber"],
    pointsMultiplier: json["pointsMultiplier"] == null ? null : json["pointsMultiplier"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "points": points == null ? null : points,
    "date": date == null ? null : date,
    "typeId": typeId == null ? null : typeId,
    "amount": amount == null ? null : amount,
    "accountOrMobileNumber": accountOrMobileNumber == null ? null : accountOrMobileNumber,
    "pointsMultiplier": pointsMultiplier == null ? null : pointsMultiplier,
  };
}

class Status {
  Status({
    this.code,
    this.message,
  });

  int? code;
  String? message;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
  };
}
