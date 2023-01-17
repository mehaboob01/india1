class HomeModel {
  PointsSummary? pointsSummary;
  AtmRewards? atmRewards;
  PointsConfiguration? pointsConfiguration;
  Null? recentRewardTransactions;

  HomeModel(
      {this.pointsSummary,
        this.atmRewards,
        this.pointsConfiguration,
        this.recentRewardTransactions});

  HomeModel.fromJson(Map<String, dynamic> json) {
    pointsSummary = json['pointsSummary'] != null
        ? new PointsSummary.fromJson(json['pointsSummary'])
        : null;
    atmRewards = json['atmRewards'] != null
        ? new AtmRewards.fromJson(json['atmRewards'])
        : null;
    pointsConfiguration = json['pointsConfiguration'] != null
        ? new PointsConfiguration.fromJson(json['pointsConfiguration'])
        : null;
    recentRewardTransactions = json['recentRewardTransactions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pointsSummary != null) {
      data['pointsSummary'] = this.pointsSummary!.toJson();
    }
    if (this.atmRewards != null) {
      data['atmRewards'] = this.atmRewards!.toJson();
    }
    if (this.pointsConfiguration != null) {
      data['pointsConfiguration'] = this.pointsConfiguration!.toJson();
    }
    data['recentRewardTransactions'] = this.recentRewardTransactions;
    return data;
  }
}

class PointsSummary {
  int? redeemablePoints;
  int? pointsEarned;
  int? pointsRedeemed;

  PointsSummary(
      {this.redeemablePoints, this.pointsEarned, this.pointsRedeemed});

  PointsSummary.fromJson(Map<String, dynamic> json) {
    redeemablePoints = json['redeemablePoints'];
    pointsEarned = json['pointsEarned'];
    pointsRedeemed = json['pointsRedeemed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['redeemablePoints'] = this.redeemablePoints;
    data['pointsEarned'] = this.pointsEarned;
    data['pointsRedeemed'] = this.pointsRedeemed;
    return data;
  }
}

class AtmRewards {
  List<int>? rewardsMultipliers;

  AtmRewards({this.rewardsMultipliers});

  AtmRewards.fromJson(Map<String, dynamic> json) {
    rewardsMultipliers = json['rewardsMultipliers'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rewardsMultipliers'] = this.rewardsMultipliers;
    return data;
  }
}

class PointsConfiguration {
  int? redeemThreshold;
  int? referFriendRewardPoints;
  int? atmWithdrawRewardPoints;

  PointsConfiguration(
      {this.redeemThreshold,
        this.referFriendRewardPoints,
        this.atmWithdrawRewardPoints});

  PointsConfiguration.fromJson(Map<String, dynamic> json) {
    redeemThreshold = json['redeemThreshold'];
    referFriendRewardPoints = json['referFriendRewardPoints'];
    atmWithdrawRewardPoints = json['atmWithdrawRewardPoints'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['redeemThreshold'] = this.redeemThreshold;
    data['referFriendRewardPoints'] = this.referFriendRewardPoints;
    data['atmWithdrawRewardPoints'] = this.atmWithdrawRewardPoints;
    return data;
  }
}
