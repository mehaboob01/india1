class FarmLoanProductModel {
  List<String>? subProducts;
  List<String>? brands;

  FarmLoanProductModel({this.subProducts, this.brands});

  FarmLoanProductModel.fromJson(Map<String, dynamic> json) {
    subProducts = json['subProducts']?.cast<String>();
    brands = json['brands']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subProducts'] = this.subProducts;
    data['brands'] = this.brands;
    return data;
  }
}