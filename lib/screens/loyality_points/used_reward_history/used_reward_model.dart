class UsedPointsHistoryModel {
  String? nextToken;
  String? previousToken;
  List<Transactions>? transactions;

  UsedPointsHistoryModel(
      {this.nextToken, this.previousToken, this.transactions});

  UsedPointsHistoryModel.fromJson(Map<String, dynamic> json) {
    nextToken = json['nextToken'];
    previousToken = json['previousToken'];
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nextToken'] = this.nextToken;
    data['previousToken'] = this.previousToken;
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transactions {
  String? id;
  int? points;
  String? date;
  String? typeId;
  int? amount;
  String? accountOrMobileNumber;
  int? pointsMultiplier;

  Transactions(
      {this.id,
        this.points,
        this.date,
        this.typeId,
        this.amount,
        this.accountOrMobileNumber,
        this.pointsMultiplier});

  Transactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    points = json['points'];
    date = json['date'];
    typeId = json['typeId'];
    amount = json['amount'];
    accountOrMobileNumber = json['accountOrMobileNumber'];
    pointsMultiplier = json['pointsMultiplier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['points'] = this.points;
    data['date'] = this.date;
    data['typeId'] = this.typeId;
    data['amount'] = this.amount;
    data['accountOrMobileNumber'] = this.accountOrMobileNumber;
    data['pointsMultiplier'] = this.pointsMultiplier;
    return data;
  }
}
