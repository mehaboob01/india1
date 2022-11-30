class CreateLoanModel {
  String? loanApplicationId;
  String? loanStage;
  String? loanType;
  String? status;
  num? loanAmount;
  LoanConfiguration? loanConfiguration;

  CreateLoanModel({
    this.loanApplicationId,
    this.loanType,
    this.status,
    this.loanStage,
    this.loanAmount,
    this.loanConfiguration
  });

  CreateLoanModel.fromJson(Map<String, dynamic> json) {
    loanApplicationId = json['loanApplicationId'];
    loanType = json['loanType'];
    status = json['status'];
    loanStage = json['loanStage'];
    loanAmount = json['loanAmount'];
    loanConfiguration = json['loanConfiguration'] != null
        ? new LoanConfiguration.fromJson(json['loanConfiguration'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loanApplicationId'] = this.loanApplicationId;
    data['loanType'] = this.loanType;
    data['status'] = this.status;
    data['loanStage'] = this.loanStage;
    data['loanAmount'] = this.loanAmount;
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
