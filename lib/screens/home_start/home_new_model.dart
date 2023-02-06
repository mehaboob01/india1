import 'dart:convert';

NewHomeModel newHomeModelFromJson(String str) =>
    NewHomeModel.fromJson(json.decode(str));

String newHomeModelToJson(NewHomeModel data) => json.encode(data.toJson());

class NewHomeModel {
  NewHomeModel({
    this.pointsSummary,
    this.atmRewards,
    this.pointsConfiguration,
    this.recentRewardTransactions,
  });

  PointsSummary? pointsSummary;
  AtmRewards? atmRewards;
  PointsConfiguration? pointsConfiguration;
  List<RecentRewardTransaction>? recentRewardTransactions;

  factory NewHomeModel.fromJson(Map<String, dynamic> json) => NewHomeModel(
        pointsSummary: json["pointsSummary"] == null
            ? null
            : PointsSummary.fromJson(json["pointsSummary"]),
        atmRewards: json["atmRewards"] == null
            ? null
            : AtmRewards.fromJson(json["atmRewards"]),
        pointsConfiguration: json["pointsConfiguration"] == null
            ? null
            : PointsConfiguration.fromJson(json["pointsConfiguration"]),
        recentRewardTransactions: json["recentRewardTransactions"] == null
            ? []
            : List<RecentRewardTransaction>.from(
                json["recentRewardTransactions"]!
                    .map((x) => RecentRewardTransaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pointsSummary": pointsSummary?.toJson(),
        "atmRewards": atmRewards?.toJson(),
        "pointsConfiguration": pointsConfiguration?.toJson(),
        "recentRewardTransactions": recentRewardTransactions == null
            ? []
            : List<dynamic>.from(
                recentRewardTransactions!.map((x) => x.toJson())),
      };
}

class AtmRewards {
  AtmRewards({
    this.rewardsMultipliers,
  });

  List<int>? rewardsMultipliers;

  factory AtmRewards.fromJson(Map<String, dynamic> json) => AtmRewards(
        rewardsMultipliers: json["rewardsMultipliers"] == null
            ? []
            : List<int>.from(json["rewardsMultipliers"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "rewardsMultipliers": rewardsMultipliers == null
            ? []
            : List<dynamic>.from(rewardsMultipliers!.map((x) => x)),
      };
}

class PointsConfiguration {
  PointsConfiguration({
    this.redeemThreshold,
    this.referFriendRewardPoints,
    this.atmWithdrawRewardPoints,
  });

  int? redeemThreshold;
  int? referFriendRewardPoints;
  int? atmWithdrawRewardPoints;

  factory PointsConfiguration.fromJson(Map<String, dynamic> json) =>
      PointsConfiguration(
        redeemThreshold: json["redeemThreshold"],
        referFriendRewardPoints: json["referFriendRewardPoints"],
        atmWithdrawRewardPoints: json["atmWithdrawRewardPoints"],
      );

  Map<String, dynamic> toJson() => {
        "redeemThreshold": redeemThreshold,
        "referFriendRewardPoints": referFriendRewardPoints,
        "atmWithdrawRewardPoints": atmWithdrawRewardPoints,
      };
}

class PointsSummary {
  PointsSummary({
    this.redeemablePoints,
    this.pointsEarned,
    this.pointsRedeemed,
  });

  int? redeemablePoints;
  int? pointsEarned;
  int? pointsRedeemed;

  factory PointsSummary.fromJson(Map<String, dynamic> json) => PointsSummary(
        redeemablePoints: json["redeemablePoints"],
        pointsEarned: json["pointsEarned"],
        pointsRedeemed: json["pointsRedeemed"],
      );

  Map<String, dynamic> toJson() => {
        "redeemablePoints": redeemablePoints,
        "pointsEarned": pointsEarned,
        "pointsRedeemed": pointsRedeemed,
      };
}

class RecentRewardTransaction {
  RecentRewardTransaction({
    this.id,
    this.points,
    this.date,
    this.typeId,
    this.expiryDate,
  });

  String? id;
  int? points;
  DateTime? date;
  String? typeId;
  DateTime? expiryDate;

  factory RecentRewardTransaction.fromJson(Map<String, dynamic> json) =>
      RecentRewardTransaction(
        id: json["id"],
        points: json["points"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        typeId: json["typeId"],
        expiryDate: json["expiryDate"] == null
            ? null
            : DateTime.parse(json["expiryDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "points": points,
        "date": date?.toIso8601String(),
        "typeId": typeId,
        "expiryDate": expiryDate?.toIso8601String(),
      };
}
