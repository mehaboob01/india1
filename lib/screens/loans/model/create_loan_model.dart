class CreateLoanModel {
  String? loanApplicationId;
  String? loanStage;
  String? loanType;
  LoanConfiguration? loanConfiguration;

  CreateLoanModel({
    this.loanApplicationId,
    this.loanStage,
    this.loanType,
    this.loanConfiguration,
  });

  CreateLoanModel.fromJson(Map<String, dynamic> json) {
    loanApplicationId = json['loanApplicationId'];
    loanStage = json['loanStage'];
    loanType = json['loanType'];
    loanConfiguration = json['loanConfiguration'] != null ? new LoanConfiguration.fromJson(json['loanConfiguration']) : this.loanConfiguration ?? null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loanApplicationId'] = this.loanApplicationId;
    data['loanStage'] = this.loanStage;
    data['loanType'] = this.loanType;
    if (this.loanConfiguration != null) {
      data['loanConfiguration'] = this.loanConfiguration!.toJson();
    }
    return data;
  }
}

class LoanConfiguration {
  num? maxLoanAmount;
  num? minLoanAmount;

  LoanConfiguration({this.maxLoanAmount,this.minLoanAmount,});

  LoanConfiguration.fromJson(Map<String, dynamic> json) {
    maxLoanAmount = json['maxLoanAmount'];
    minLoanAmount = json['minLoanAmount'];
  }
//9409993057
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maxLoanAmount'] = this.maxLoanAmount;
    data['minLoanAmount'] = this.minLoanAmount;
    return data;
  }
}
