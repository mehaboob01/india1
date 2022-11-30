class BankDetailsModel {
  PreferredAccount? preferredAccount;
  List<PreferredAccount>? accounts;

  BankDetailsModel({this.preferredAccount, this.accounts});

  BankDetailsModel.fromJson(Map<String, dynamic> json) {
    preferredAccount = json['preferredAccount'] != null ? new PreferredAccount.fromJson(json['preferredAccount']) : null;
    if (json['accounts'] != null) {
      accounts = <PreferredAccount>[];
      json['accounts'].forEach((v) {
        accounts!.add(new PreferredAccount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.preferredAccount != null) {
      data['preferredAccount'] = this.preferredAccount!.toJson();
    }
    if (this.accounts != null) {
      data['accounts'] = this.accounts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PreferredAccount {
  String? id;
  String? name;
  String? maskAccountNumber;
  String? ifscCode;
  String? accountType;

  PreferredAccount({this.id, this.name, this.maskAccountNumber, this.ifscCode, this.accountType});

  PreferredAccount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    maskAccountNumber = json['maskAccountNumber'];
    ifscCode = json['ifscCode'];
    accountType = json['accountType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['maskAccountNumber'] = this.maskAccountNumber;
    data['ifscCode'] = this.ifscCode;
    data['accountType'] = this.accountType;
    return data;
  }
}
