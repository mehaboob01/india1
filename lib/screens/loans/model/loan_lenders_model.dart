class LoanLendersModel {
  Null? nextToken;
  List<Lenders>? lenders;

  LoanLendersModel({this.nextToken, this.lenders});

  LoanLendersModel.fromJson(Map<String, dynamic> json) {
    nextToken = json['nextToken'];
    if (json['lenders'] != null) {
      lenders = <Lenders>[];
      json['lenders'].forEach((v) {
        lenders!.add(new Lenders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nextToken'] = this.nextToken;
    if (this.lenders != null) {
      data['lenders'] = this.lenders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lenders {
  String? id;
  String? logoUrl;
  Details? details;

  Lenders({this.id, this.logoUrl, this.details});

  Lenders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logoUrl = json['logoUrl'];
    details =
    json['details'] != null ? new Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logoUrl'] = this.logoUrl;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    return data;
  }
}

class Details {
  String? loanInterest;
  String? tenure;
  String? lender;
  String? keywords;
  String? loanAmount;
  String? processTime;
  String? url;

  Details(
      {this.loanInterest,
        this.tenure,
        this.lender,
        this.keywords,
        this.loanAmount,
        this.processTime,
        this.url});

  Details.fromJson(Map<String, dynamic> json) {
    loanInterest = json['Loan Interest'];
    tenure = json['Tenure'];
    lender = json['lender'];
    keywords = json['Keywords'];
    loanAmount = json['Loan Amount'];
    processTime = json['Process Time'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Loan Interest'] = this.loanInterest;
    data['Tenure'] = this.tenure;
    data['lender'] = this.lender;
    data['Keywords'] = this.keywords;
    data['Loan Amount'] = this.loanAmount;
    data['Process Time'] = this.processTime;
    data['url'] = this.url;
    return data;
  }
}
