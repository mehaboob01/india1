class ProfileDetailsModel {
  String? id;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? panNumber;
  String? occupation;
  num? income;
  String? preferredLanguage;
  String? dateOfBirth;
  String? email;
  String? membershipId;
  String? uniqueId;
  String? alternateNumber;
  String? imageName;
  String? gender;
  String? employmentType;
  String? maritalStatus;
  String? salaryMode;
  GeoLocation? geoLocation;
  Address? address;
  String? imageUrl;
  int? residingTenure;
  String? companyName;
  String? designation;
  int? workExperience;
  String? officeAddressLine1;
  String? officeAddressLine2;
  String? activeNetBanking;
  String? activeEmi;
  int? noOfActiveEmi;
  String? highestQualification;

  ProfileDetailsModel(
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
      this.imageUrl,
      this.residingTenure,
      this.companyName,
      this.designation,
      this.workExperience,
      this.officeAddressLine1,
      this.officeAddressLine2,
      this.activeNetBanking,
      this.activeEmi,
      this.noOfActiveEmi,
      this.highestQualification});

  ProfileDetailsModel.fromJson(Map<String, dynamic> json) {
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
    geoLocation = json['geoLocation'] != null
        ? new GeoLocation.fromJson(json['geoLocation'])
        : null;
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    imageUrl = json['imageUrl'];
    residingTenure = json['residingTenure'];
    companyName = json['companyName'];
    designation = json['designation'];
    workExperience = json['workExperience'];
    officeAddressLine1 = json['officeAddressLine1'];
    officeAddressLine2 = json['officeAddressLine2'];
    activeNetBanking = json['activeNetBanking'];
    activeEmi = json['activeEmi'];
    noOfActiveEmi = json['noOfActiveEmi'];
    highestQualification = json['highestQualification'];

    print("inside model json");
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
    if (this.geoLocation != null) {
      data['geoLocation'] = this.geoLocation!.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['imageUrl'] = this.imageUrl;
    data['residingTenure'] = this.residingTenure;
    data['companyName'] = this.companyName;
    data['designation'] = this.designation;
    data['workExperience'] = this.workExperience;
    data['officeAddressLine1'] = this.officeAddressLine1;
    data['officeAddressLine2'] = this.officeAddressLine2;
    data['activeNetBanking'] = this.activeNetBanking;
    data['activeEmi'] = this.activeEmi;
    data['noOfActiveEmi'] = this.noOfActiveEmi;
    data['highestQualification'] = this.highestQualification;
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

class GeoLocation {
  double? lat;
  double? lon;

  GeoLocation({this.lat, this.lon});

  GeoLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    return data;
  }
}
