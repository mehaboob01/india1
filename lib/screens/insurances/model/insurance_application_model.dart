class InsuranceApplicationModel {
  String? id;
  String? stage;
  String? type;
  List<Plans>? plans;

  InsuranceApplicationModel({this.id, this.stage, this.type, this.plans});

  InsuranceApplicationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stage = json['stage'];
    type = json['type'];
    if (json['plans'] != null) {
      plans = <Plans>[];
      json['plans'].forEach((v) {
        plans!.add(new Plans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['stage'] = this.stage;
    data['type'] = this.type;
    if (this.plans != null) {
      data['plans'] = this.plans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Plans {
  String? id;
  String? name;
  String? type;
  String? imageUrl;
  num? insuredAmount;
  num? amount;

  Plans(
      {this.id,
        this.name,
        this.type,
        this.imageUrl,
        this.insuredAmount,
        this.amount});

  Plans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    imageUrl = json['imageUrl'];
    insuredAmount = json['insuredAmount'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['imageUrl'] = this.imageUrl;
    data['insuredAmount'] = this.insuredAmount;
    data['amount'] = this.amount;
    return data;
  }
}