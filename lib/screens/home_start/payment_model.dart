class PaymentModel {
  String? link;
  String? sessionId;
  String? shortLink;

  PaymentModel({this.link, this.sessionId, this.shortLink});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    sessionId = json['sessionId'];
    shortLink = json['shortLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    data['sessionId'] = this.sessionId;
    data['shortLink'] = this.shortLink;
    return data;
  }
}
