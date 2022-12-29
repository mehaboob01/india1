class LoanLenderOthersModel {
  String? nextToken;
  List<Lenderss>? lenders;

  LoanLenderOthersModel({this.nextToken, this.lenders});

  LoanLenderOthersModel.fromJson(Map<String, dynamic> json) {
    nextToken = json['nextToken'];
    if (json['lenders'] != null) {
      lenders = <Lenderss>[];
      json['lenders'].forEach((v) {
        lenders!.add(new Lenderss.fromJson(v));
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

class Lenderss {
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
  String? loanApplyType;
  String? redirectUrl;

  Lenderss(
      {this.id,
      this.logoURL,
      this.loanTitle,
      this.loanType,
      this.keywords,
      this.loanMaxAmount,
      this.minTenureInMonths,
      this.maxTenureInMonths,
      this.minInterestRate,
      this.maxInterestRate,
      this.loanApplyType,
      this.redirectUrl});

  Lenderss.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logoURL = json['logoUrl'];
    loanTitle = json['loanTitle'];
    loanType = json['loanType'];
    keywords = json['keywords'].cast<String>();
    loanMaxAmount = json['loanMaxAmount'];
    minTenureInMonths = json['minTenureInMonths'];
    maxTenureInMonths = json['maxTenureInMonths'];
    minInterestRate = json['minInterestRate'];
    maxInterestRate = json['maxInterestRate'];
    loanApplyType = json['loanApplyType'];
    redirectUrl = json['redirectUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logoUrl'] = this.logoURL;
    data['loanTitle'] = this.loanTitle;
    data['loanType'] = this.loanType;
    data['keywords'] = this.keywords;
    data['loanMaxAmount'] = this.loanMaxAmount;
    data['minTenureInMonths'] = this.minTenureInMonths;
    data['maxTenureInMonths'] = this.maxTenureInMonths;
    data['minInterestRate'] = this.minInterestRate;
    data['maxInterestRate'] = this.maxInterestRate;
    data['loanApplyType'] = this.loanApplyType;
    data['redirectUrl'] = this.redirectUrl;
    return data;
  }
}