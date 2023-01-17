class RcOperatorModel {
  List<Operators>? operators;

  RcOperatorModel({this.operators});

  RcOperatorModel.fromJson(Map<String, dynamic> json) {
    if (json['operators'] != null) {
      operators = <Operators>[];
      json['operators'].forEach((v) {
        operators!.add(new Operators.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.operators != null) {
      data['operators'] = this.operators!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Operators {
  String? id;
  String? name;

  Operators({this.id, this.name});

  Operators.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
