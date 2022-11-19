class LoanLendersModel {
  String? nextToken;
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
  String? logoURL;
  String? loanTitle;
  String? loanType;
  List<String>? keywords;
  num? loanMaxAmount;
  num? minTenureInMonths;
  num? maxTenureInMonths;
  double? minInterestRate;
  double? maxInterestRate;

  Lenders(
      {this.id,
        this.logoURL,
        this.loanTitle,
        this.loanType,
        this.keywords,
        this.loanMaxAmount,
        this.minTenureInMonths,
        this.maxTenureInMonths,
        this.minInterestRate,
        this.maxInterestRate});

  Lenders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logoURL = json['logoURL'];
    loanTitle = json['loanTitle'];
    loanType = json['loanType'];
    keywords = json['keywords'].cast<String>();
    loanMaxAmount = json['loanMaxAmount'];
    minTenureInMonths = json['minTenureInMonths'];
    maxTenureInMonths = json['maxTenureInMonths'];
    minInterestRate = json['minInterestRate'];
    maxInterestRate = json['maxInterestRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logoURL'] = this.logoURL;
    data['loanTitle'] = this.loanTitle;
    data['loanType'] = this.loanType;
    data['keywords'] = this.keywords;
    data['loanMaxAmount'] = this.loanMaxAmount;
    data['minTenureInMonths'] = this.minTenureInMonths;
    data['maxTenureInMonths'] = this.maxTenureInMonths;
    data['minInterestRate'] = this.minInterestRate;
    data['maxInterestRate'] = this.maxInterestRate;
    return data;
  }
}
