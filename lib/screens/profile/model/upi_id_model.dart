class UpiIdModel {
  List<UpiIds>? upiIds;

  UpiIdModel({this.upiIds});

  UpiIdModel.fromJson(Map<String, dynamic> json) {
    if (json['upiIds'] != null) {
      upiIds = <UpiIds>[];
      json['upiIds'].forEach((v) {
        upiIds!.add(new UpiIds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.upiIds != null) {
      data['upiIds'] = this.upiIds!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UpiIds {
  String? id;
  String? upiId;

  UpiIds({this.id, this.upiId});

  UpiIds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    upiId = json['upiId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['upiId'] = this.upiId;
    return data;
  }
}
