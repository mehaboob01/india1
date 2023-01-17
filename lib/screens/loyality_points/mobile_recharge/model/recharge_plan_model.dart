class PlanesModel {
  List<Plans>? plans;

  PlanesModel({this.plans});

  PlanesModel.fromJson(Map<String, dynamic> json) {
    if (json['plans'] != null) {
      plans = <Plans>[];
      json['plans'].forEach((v) {
        plans!.add(new Plans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.plans != null) {
      data['plans'] = this.plans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Plans {
  String? type;
  int? amount;
  String? description;
  String? validity;

  Plans({this.type, this.amount, this.description, this.validity});

  Plans.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    amount = json['amount'];
    description = json['description'];
    validity = json['validity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['description'] = this.description;
    data['validity'] = this.validity;
    return data;
  }
}
