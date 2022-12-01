class InsuranceSummaryModel {
  String? applicationId;
  String? logoUrl;
  String? name;
  String? type;
  num? premiumAmount;
  num? sumInsured;
  num? tenureInYears;
  num? gstAmount;
  num? totalAmount;
  Nominee? nominee;
  String? tocUrl;
  String? tocVersion;
  Profile? profile;

  InsuranceSummaryModel(
      {this.applicationId,
        this.logoUrl,
        this.name,
        this.type,
        this.premiumAmount,
        this.sumInsured,
        this.tenureInYears,
        this.gstAmount,
        this.totalAmount,
        this.nominee,
        this.tocUrl,
        this.tocVersion,
        this.profile});

  InsuranceSummaryModel.fromJson(Map<String, dynamic> json) {
    applicationId = json['applicationId'];
    logoUrl = json['logoUrl'];
    name = json['name'];
    type = json['type'];
    premiumAmount = json['premiumAmount'];
    sumInsured = json['sumInsured'];
    tenureInYears = json['tenureInYears'];
    gstAmount = json['gstAmount'];
    totalAmount = json['totalAmount'];
    nominee =
    json['nominee'] != null ? new Nominee.fromJson(json['nominee']) : null;
    tocUrl = json['tocUrl'];
    tocVersion = json['tocVersion'];
    profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['applicationId'] = this.applicationId;
    data['logoUrl'] = this.logoUrl;
    data['name'] = this.name;
    data['type'] = this.type;
    data['premiumAmount'] = this.premiumAmount;
    data['sumInsured'] = this.sumInsured;
    data['tenureInYears'] = this.tenureInYears;
    data['gstAmount'] = this.gstAmount;
    data['totalAmount'] = this.totalAmount;
    if (this.nominee != null) {
      data['nominee'] = this.nominee!.toJson();
    }
    data['tocUrl'] = this.tocUrl;
    data['tocVersion'] = this.tocVersion;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    return data;
  }
}

class Nominee {
  String? name;
  String? relationship;
  String? dateOfBirth;
  String? gender;

  Nominee({this.name, this.relationship, this.dateOfBirth, this.gender});

  Nominee.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    relationship = json['relationship'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['relationship'] = this.relationship;
    data['dateOfBirth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    return data;
  }
}

class Profile {
  String? id;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? panNumber;
  String? occupation;
  num? income;
  Null? preferredLanguage;
  String? dateOfBirth;
  String? email;
  String? membershipId;
  String? uniqueId;
  String? alternateNumber;
  String? imageName;
  String? gender;
  String? employmentType;
  String? maritalStatus;
  Null? salaryMode;
  Null? geoLocation;
  Address? address;
  String? imageUrl;

  Profile(
      {this.id,
        this.firstName,
        this.lastName,
        this.mobileNumber,
        this.panNumber,
        this.occupation,
        this.income,
        this.preferredLanguage,
        this.dateOfBirth,
        this.email,
        this.membershipId,
        this.uniqueId,
        this.alternateNumber,
        this.imageName,
        this.gender,
        this.employmentType,
        this.maritalStatus,
        this.salaryMode,
        this.geoLocation,
        this.address,
        this.imageUrl});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobileNumber = json['mobileNumber'];
    panNumber = json['panNumber'];
    occupation = json['occupation'];
    income = json['income'];
    preferredLanguage = json['preferredLanguage'];
    dateOfBirth = json['dateOfBirth'];
    email = json['email'];
    membershipId = json['membershipId'];
    uniqueId = json['uniqueId'];
    alternateNumber = json['alternateNumber'];
    imageName = json['imageName'];
    gender = json['gender'];
    employmentType = json['employmentType'];
    maritalStatus = json['maritalStatus'];
    salaryMode = json['salaryMode'];
    geoLocation = json['geoLocation'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mobileNumber'] = this.mobileNumber;
    data['panNumber'] = this.panNumber;
    data['occupation'] = this.occupation;
    data['income'] = this.income;
    data['preferredLanguage'] = this.preferredLanguage;
    data['dateOfBirth'] = this.dateOfBirth;
    data['email'] = this.email;
    data['membershipId'] = this.membershipId;
    data['uniqueId'] = this.uniqueId;
    data['alternateNumber'] = this.alternateNumber;
    data['imageName'] = this.imageName;
    data['gender'] = this.gender;
    data['employmentType'] = this.employmentType;
    data['maritalStatus'] = this.maritalStatus;
    data['salaryMode'] = this.salaryMode;
    data['geoLocation'] = this.geoLocation;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}

class Address {
  String? addressLine1;
  String? addressLine2;
  String? postCode;
  String? city;
  String? state;

  Address(
      {this.addressLine1,
        this.addressLine2,
        this.postCode,
        this.city,
        this.state});

  Address.fromJson(Map<String, dynamic> json) {
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    postCode = json['postCode'];
    city = json['city'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addressLine1'] = this.addressLine1;
    data['addressLine2'] = this.addressLine2;
    data['postCode'] = this.postCode;
    data['city'] = this.city;
    data['state'] = this.state;
    return data;
  }
}
