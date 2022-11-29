class InsuranceRecentTransactionModel {
  List<RecentTransactions>? recentTransactions;

  InsuranceRecentTransactionModel({this.recentTransactions});

  InsuranceRecentTransactionModel.fromJson(Map<String, dynamic> json) {
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
  String? logoUrl;
  String? title;
  String? type;
  double? amount;
  String? dateTime;
  String? status;

  RecentTransactions(
      {this.id,
        this.logoUrl,
        this.title,
        this.type,
        this.amount,
        this.dateTime,
        this.status});

  RecentTransactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logoUrl = json['logoUrl'];
    title = json['title'];
    type = json['type'];
    amount = json['amount'];
    dateTime = json['dateTime'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logoUrl'] = this.logoUrl;
    data['title'] = this.title;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['dateTime'] = this.dateTime;
    data['status'] = this.status;
    return data;
  }
}
