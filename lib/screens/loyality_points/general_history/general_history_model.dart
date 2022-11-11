// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/cupertino.dart';

class GeneralHistoryModel {
  String? name;
  String? type;
  String? loanAmount;
  DateTime? appliedOn;
  String? status;
  String? amountCoveres;
  DateTime? boughtOn;
  String? icon;
  GeneralHistoryModel(
      {this.name,
      this.type,
      this.loanAmount,
      this.appliedOn,
      this.status,
      this.amountCoveres,
      this.boughtOn,
      this.icon});
  factory GeneralHistoryModel.fromJson(Map<String, dynamic> json) {
    return GeneralHistoryModel(
        name: json['name'],
        type: json['type'],
        loanAmount: json['loanAmount'],
        appliedOn: json["appliedOn"],
        status: json['status'],
        amountCoveres: json['amountCoveres'],
        boughtOn: json['boughtOn'],
        icon: json['icon']);
  }
}
