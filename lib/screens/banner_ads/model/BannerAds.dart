class BanerAdsMOdel {
  List<Ads>? ads;

  BanerAdsMOdel({this.ads});

  BanerAdsMOdel.fromJson(Map<String, dynamic> json) {
    if (json['ads'] != null) {
      ads = <Ads>[];
      json['ads'].forEach((v) {
        ads!.add(new Ads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ads != null) {
      data['ads'] = this.ads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ads {
  String? id;
  String? route;
  String? redirectUrl;
  String? title;
  String? subTitle;
  String? imageUrl;
  String? adPlacement;
  String? languageCode;

  Ads(
      {this.id,
        this.route,
        this.redirectUrl,
        this.title,
        this.subTitle,
        this.imageUrl,
        this.adPlacement,
        this.languageCode});

  Ads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    route = json['route'];
    redirectUrl = json['redirectUrl'];
    title = json['title'];
    subTitle = json['subTitle'];
    imageUrl = json['imageUrl'];
    adPlacement = json['adPlacement'];
    languageCode = json['languageCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['route'] = this.route;
    data['redirectUrl'] = this.redirectUrl;
    data['title'] = this.title;
    data['subTitle'] = this.subTitle;
    data['imageUrl'] = this.imageUrl;
    data['adPlacement'] = this.adPlacement;
    data['languageCode'] = this.languageCode;
    return data;
  }
}
