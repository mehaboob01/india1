class LoanStatusModel {
  String? loanApplicationId;
  String? loanApplicationStatus;
  String? loanProviderId;

  LoanStatusModel({
    this.loanApplicationId,
    this.loanApplicationStatus,
    this.loanProviderId,
  });

  LoanStatusModel.fromJson(Map<String, dynamic> json) {
    loanApplicationId = json['loanApplicationId'];
    loanApplicationStatus = json['loanApplicationStatus'];
    loanProviderId = json['loanProviderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loanApplicationId'] = this.loanApplicationId;
    data['loanApplicationStatus'] = this.loanApplicationStatus;
    data['loanProviderId'] = this.loanProviderId;
    return data;
  }
}
