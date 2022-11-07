// To parse this JSON data, do
//
//     final fetchCustomerBanksModel = fetchCustomerBanksModelFromJson(jsonString);

import 'dart:convert';

FetchCustomerBanksModel fetchCustomerBanksModelFromJson(String str) => FetchCustomerBanksModel.fromJson(json.decode(str));

String fetchCustomerBanksModelToJson(FetchCustomerBanksModel data) => json.encode(data.toJson());

class FetchCustomerBanksModel {
  FetchCustomerBanksModel({
    this.data,
    this.status,
  });

  Data? data;
  Status? status;

  factory FetchCustomerBanksModel.fromJson(Map<String, dynamic> json) => FetchCustomerBanksModel(
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
    this.preferredAccount,
    this.accounts,
  });

  Account? preferredAccount;
  List<Account>? accounts;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    preferredAccount: json["preferredAccount"] == null ? null : Account.fromJson(json["preferredAccount"]),
    accounts: json["accounts"] == null ? null : List<Account>.from(json["accounts"].map((x) => Account.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "preferredAccount": preferredAccount == null ? null : preferredAccount!.toJson(),
    "accounts": accounts == null ? null : List<dynamic>.from(accounts!.map((x) => x.toJson())),
  };
}

class Account {
  Account({
    this.id,
    this.name,
    this.maskAccountNumber,
    this.ifscCode,
    this.accountType,
  });

  String? id;
  String? name;
  String? maskAccountNumber;
  String? ifscCode;
  String? accountType;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    maskAccountNumber: json["maskAccountNumber"] == null ? null : json["maskAccountNumber"],
    ifscCode: json["ifscCode"] == null ? null : json["ifscCode"],
    accountType: json["accountType"] == null ? null : json["accountType"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "maskAccountNumber": maskAccountNumber == null ? null : maskAccountNumber,
    "ifscCode": ifscCode == null ? null : ifscCode,
    "accountType": accountType == null ? null : accountType,
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
