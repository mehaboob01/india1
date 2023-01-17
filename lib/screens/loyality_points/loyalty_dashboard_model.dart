class LoyaltyDashboardModel {
  PointsSummary? pointsSummary;
  AtmRewards? atmRewards;
  PointsConfiguration? pointsConfiguration;
  List<RecentRewardTransactions>? recentRewardTransactions;

  LoyaltyDashboardModel(
      {this.pointsSummary,
        this.atmRewards,
        this.pointsConfiguration,
        this.recentRewardTransactions});

  LoyaltyDashboardModel.fromJson(Map<String, dynamic> json) {
    pointsSummary = json['pointsSummary'] != null
        ? new PointsSummary.fromJson(json['pointsSummary'])
        : null;
    atmRewards = json['atmRewards'] != null
        ? new AtmRewards.fromJson(json['atmRewards'])
        : null;
    pointsConfiguration = json['pointsConfiguration'] != null
        ? new PointsConfiguration.fromJson(json['pointsConfiguration'])
        : null;
    if (json['recentRewardTransactions'] != null) {
      recentRewardTransactions = <RecentRewardTransactions>[];
      json['recentRewardTransactions'].forEach((v) {
        recentRewardTransactions!.add(new RecentRewardTransactions.fromJson(v));
      });
    }
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
    if (this.recentRewardTransactions != null) {
      data['recentRewardTransactions'] =
          this.recentRewardTransactions!.map((v) => v.toJson()).toList();
    }
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

class RecentRewardTransactions {
  String? id;
  int? points;
  String? date;
  String? typeId;
  String? expiryDate;

  RecentRewardTransactions(
      {this.id, this.points, this.date, this.typeId, this.expiryDate});

  RecentRewardTransactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    points = json['points'];
    date = json['date'];
    typeId = json['typeId'];
    expiryDate = json['expiryDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['points'] = this.points;
    data['date'] = this.date;
    data['typeId'] = this.typeId;
    data['expiryDate'] = this.expiryDate;
    return data;
  }
}
