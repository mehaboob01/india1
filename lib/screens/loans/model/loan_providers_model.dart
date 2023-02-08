// class LoanProvidersModel {
//   String? nextToken;
//   List<Providers>? providers;
//
//   LoanProvidersModel({this.nextToken, this.providers});
//
//   LoanProvidersModel.fromJson(Map<String, dynamic> json) {
//     nextToken = json['nextToken'];
//     if (json['providers'] != null) {
//       providers = <Providers>[];
//       json['providers'].forEach((v) {
//         providers!.add(new Providers.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['nextToken'] = this.nextToken;
//     if (this.providers != null) {
//       data['providers'] = this.providers!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Providers {
//   String? id;
//   String? name;
//   String? subTitle;
//   String? logoURL;
//
//   Providers({this.id, this.name, this.subTitle, this.logoURL});
//
//   Providers.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     subTitle = json['subTitle'];
//     logoURL = json['logoUrl'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['subTitle'] = this.subTitle;
//     data['logoUrl'] = this.logoURL;
//     return data;
//   }
// }


class LoanProvidersModel {
  String? nextToken;
  List<Providers>? providers;

  LoanProvidersModel({this.nextToken, this.providers});

  LoanProvidersModel.fromJson(Map<String, dynamic> json) {
    nextToken = json['nextToken'];
    if (json['providers'] != null) {
      providers = <Providers>[];
      json['providers'].forEach((v) {
        providers!.add(new Providers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nextToken'] = this.nextToken;
    if (this.providers != null) {
      data['providers'] = this.providers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Providers {
  String? id;
  String? name;
  String? subTitle;
  String? logoURL;
  bool? redirect;
  String? redirectLink;

  Providers(
      {this.id,
        this.name,
        this.subTitle,
        this.logoURL,
        this.redirect,
        this.redirectLink});

  Providers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    subTitle = json['subTitle'];
    logoURL = json['logoUrl'];
    redirect = json['redirect'];
    redirectLink = json['redirectLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['subTitle'] = this.subTitle;
    data['logoUrl'] = this.logoURL;
    data['redirect'] = this.redirect;
    data['redirectLink'] = this.redirectLink;
    return data;
  }
}