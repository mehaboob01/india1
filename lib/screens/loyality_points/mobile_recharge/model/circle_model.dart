class RcCircleModel {
  List<Circles>? circles;

  RcCircleModel({this.circles});

  RcCircleModel.fromJson(Map<String, dynamic> json) {
    if (json['circles'] != null) {
      circles = <Circles>[];
      json['circles'].forEach((v) {
        circles!.add(new Circles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.circles != null) {
      data['circles'] = this.circles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Circles {
  String? id;
  String? name;

  Circles({this.id, this.name});

  Circles.fromJson(Map<String, dynamic> json) {
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
