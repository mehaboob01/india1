// // To parse this JSON data, do
// //
// //     final newLendersModel = newLendersModelFromJson(jsonString);
//
// import 'dart:convert';
//
// NewLendersModel newLendersModelFromJson(String str) => NewLendersModel.fromJson(json.decode(str));
//
// String newLendersModelToJson(NewLendersModel data) => json.encode(data.toJson());
//
// class NewLendersModel {
//   NewLendersModel({
//     this.data,
//     this.status,
//   });
//
//   Data? data;
//   Status? status;
//
//   factory NewLendersModel.fromJson(Map<String, dynamic> json) => NewLendersModel(
//     data: json["data"] == null ? null : Data.fromJson(json["data"]),
//     status: json["status"] == null ? null : Status.fromJson(json["status"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "data": data == null ? null : data!.toJson(),
//     "status": status == null ? null : status!.toJson(),
//   };
// }
//
// class Data {
//   Data({
//     this.nextToken,
//     this.lenders,
//   });
//
//   dynamic nextToken;
//   List<Lender>? lenders;
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     nextToken: json["nextToken"],
//     lenders: json["lenders"] == null ? null : List<Lender>.from(json["lenders"].map((x) => Lender.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "nextToken": nextToken,
//     "lenders": lenders == null ? null : List<dynamic>.from(lenders!.map((x) => x.toJson())),
//   };
// }
//
// class Lender {
//   Lender({
//     this.id,
//     this.detailss,
//   });
//
//   String? id;
//   Details? detailss;
//
//   factory Lender.fromJson(Map<String, dynamic> json) => Lender(
//     id: json["id"] == null ? null : json["id"],
//     detailss: json["details"] == null ? null : Details.fromJson(json["details"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id == null ? null : id,
//     "details": detailss == null ? null : detailss!.toJson(),
//   };
// }
//
// class Details {
//   Details({
//     this.loanInterest,
//     this.tenure,
//     this.lender,
//     this.keywords,
//     this.loanAmount,
//     this.processTime,
//     this.url,
//   });
//
//   String? loanInterest;
//   String? tenure;
//   String? lender;
//   String? keywords;
//   String? loanAmount;
//   String? processTime;
//   String? url;
//
//   factory Details.fromJson(Map<String, dynamic> json) => Details(
//     loanInterest: json["Loan Interest"] == null ? null : json["Loan Interest"],
//     tenure: json["Tenure"] == null ? null : json["Tenure"],
//     lender: json["lender"] == null ? null : json["lender"],
//     keywords: json["Keywords"] == null ? null : json["Keywords"],
//     loanAmount: json["Loan Amount"] == null ? null : json["Loan Amount"],
//     processTime: json["Process Time"] == null ? null : json["Process Time"],
//     url: json["url"] == null ? null : json["url"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Loan Interest": loanInterest == null ? null : loanInterest,
//     "Tenure": tenure == null ? null : tenure,
//     "lender": lender == null ? null : lender,
//     "Keywords": keywords == null ? null : keywords,
//     "Loan Amount": loanAmount == null ? null : loanAmount,
//     "Process Time": processTime == null ? null : processTime,
//     "url": url == null ? null : url,
//   };
// }
//
// class Status {
//   Status({
//     this.code,
//     this.message,
//   });
//
//   int? code;
//   String? message;
//
//   factory Status.fromJson(Map<String, dynamic> json) => Status(
//     code: json["code"] == null ? null : json["code"],
//     message: json["message"] == null ? null : json["message"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "code": code == null ? null : code,
//     "message": message == null ? null : message,
//   };
// }
// / To parse this JSON data, do
//
//     final NewLendersModel = NewLendersModelFromJson(jsonString);
import 'dart:convert';

NewLendersModel NewLendersModelFromJson(String str) => NewLendersModel.fromJson(json.decode(str));
String NewLendersModelToJson(NewLendersModel data) => json.encode(data.toJson());

class NewLendersModel {
  NewLendersModel({
    this.nextToken,
    this.lenders,
  });
  dynamic nextToken;
  List<Lender>? lenders;
  factory NewLendersModel.fromJson(Map<String, dynamic> json) => NewLendersModel(
        nextToken: json["nextToken"],
        lenders:
            List<Lender>.from(json["lenders"].map((x) => Lender.fromJson(x))),
      );
  Map<String, dynamic> toJson() => {
        "nextToken": nextToken,
        "lenders": List<dynamic>.from(lenders!.map((x) => x.toJson())),
      };
}

class Lender {
  Lender({
    this.id,
    this.details,
  });
  String? id;
  Details? details;
  factory Lender.fromJson(Map<String, dynamic> json) => Lender(
        id: json["id"],
        details: Details.fromJson(json["details"]),
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "details": details!.toJson(),
      };
}

class Details {
  Details({
    this.loanInterest,
    this.tenure,
    this.lender,
    this.keywords,
    this.loanAmount,
    this.processTime,
    this.url,
  });
  String? loanInterest;
  String? tenure;
  String? lender;
  String? keywords;
  String? loanAmount;
  String? processTime;
  String? url;
  factory Details.fromJson(Map<String, dynamic> json) => Details(
        loanInterest: json["Loan Interest"],
        tenure: json["Tenure"],
        lender: json["lender"],
        keywords: json["Keywords"],
        loanAmount: json["Loan Amount"],
        processTime: json["Process Time"],
        url: json["url"],
      );
  Map<String, dynamic> toJson() => {
        "Loan Interest": loanInterest,
        "Tenure": tenure,
        "lender": lender,
        "Keywords": keywords,
        "Loan Amount": loanAmount,
        "Process Time": processTime,
        "url": url,
      };
}
