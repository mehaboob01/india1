class RecentTransactionModel {
  List<RecentTransactions>? recentTransactions = [];

  RecentTransactionModel({this.recentTransactions});

  RecentTransactionModel.fromJson(Map<String, dynamic> json) {
    if (json['recentTransactions'] != null) {
      recentTransactions = <RecentTransactions>[];
      json['recentTransactions'].forEach((v) {
        recentTransactions!.add(new RecentTransactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recentTransactions != null) {
      data['recentTransactions'] =
          this.recentTransactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecentTransactions {
  String? id;
  String? logoURL;
  String? loanTitle;
  String? loanType;
  List<String>? keywords;
  num? loanAmount;
  String? loanAppliedOn;
  String? status;

  RecentTransactions(
      {this.id,
        this.logoURL,
        this.loanTitle,
        this.loanType,
        this.keywords,
        this.loanAmount,
        this.loanAppliedOn,
        this.status});

  RecentTransactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logoURL = json['logoURL'];
    loanTitle = json['loanTitle'];
    loanType = json['loanType'];
    keywords = json['keywords'].cast<String>();
    loanAmount = json['loanAmount'];
    loanAppliedOn = json['loanAppliedOn'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logoURL'] = this.logoURL;
    data['loanTitle'] = this.loanTitle;
    data['loanType'] = this.loanType;
    data['keywords'] = this.keywords;
    data['loanAmount'] = this.loanAmount;
    data['loanAppliedOn'] = this.loanAppliedOn;
    data['status'] = this.status;
    return data;
  }
}
