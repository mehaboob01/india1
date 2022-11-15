
import 'dart:convert';

LoyaltyDashboardModel loyaltyDashboardModelFromJson(String str) => LoyaltyDashboardModel.fromJson(json.decode(str));

String loyaltyDashboardModelToJson(LoyaltyDashboardModel data) => json.encode(data.toJson());

class LoyaltyDashboardModel {
  LoyaltyDashboardModel({
    this.data,
    this.status,
  });

  Data? data;
  Status? status;

  factory LoyaltyDashboardModel.fromJson(Map<String, dynamic> json) => LoyaltyDashboardModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data!.toJson(),
    "status": status == null ? null : status!.toJson(),
  };
}

class Data {
  Data({
    this.pointsSummary,
    this.atmRewards,
    this.pointsConfiguration,
    this.recentRewardTransactions,
  });

  PointsSummary? pointsSummary;
  AtmRewards? atmRewards;
  PointsConfiguration? pointsConfiguration;
  List<RecentRewardTransaction>? recentRewardTransactions;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pointsSummary: json["pointsSummary"] == null ? null : PointsSummary.fromJson(json["pointsSummary"]),
    atmRewards: json["atmRewards"] == null ? null : AtmRewards.fromJson(json["atmRewards"]),
    pointsConfiguration: json["pointsConfiguration"] == null ? null : PointsConfiguration.fromJson(json["pointsConfiguration"]),
    recentRewardTransactions: json["recentRewardTransactions"] == null ? null : List<RecentRewardTransaction>.from(json["recentRewardTransactions"].map((x) => RecentRewardTransaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pointsSummary": pointsSummary == null ? null : pointsSummary!.toJson(),
    "atmRewards": atmRewards == null ? null : atmRewards!.toJson(),
    "pointsConfiguration": pointsConfiguration == null ? null : pointsConfiguration!.toJson(),
    "recentRewardTransactions": recentRewardTransactions == null ? null : List<dynamic>.from(recentRewardTransactions!.map((x) => x.toJson())),
  };
}

class AtmRewards {
  AtmRewards({
    this.rewardsMultipliers,
  });

  List<int>? rewardsMultipliers;

  factory AtmRewards.fromJson(Map<String, dynamic> json) => AtmRewards(
    rewardsMultipliers: json["rewardsMultipliers"] == null ? null : List<int>.from(json["rewardsMultipliers"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "rewardsMultipliers": rewardsMultipliers == null ? null : List<dynamic>.from(rewardsMultipliers!.map((x) => x)),
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

  factory PointsConfiguration.fromJson(Map<String, dynamic> json) => PointsConfiguration(
    redeemThreshold: json["redeemThreshold"] == null ? null : json["redeemThreshold"],
    referFriendRewardPoints: json["referFriendRewardPoints"] == null ? null : json["referFriendRewardPoints"],
    atmWithdrawRewardPoints: json["atmWithdrawRewardPoints"] == null ? null : json["atmWithdrawRewardPoints"],
  );

  Map<String, dynamic> toJson() => {
    "redeemThreshold": redeemThreshold == null ? null : redeemThreshold,
    "referFriendRewardPoints": referFriendRewardPoints == null ? null : referFriendRewardPoints,
    "atmWithdrawRewardPoints": atmWithdrawRewardPoints == null ? null : atmWithdrawRewardPoints,
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
    redeemablePoints: json["redeemablePoints"] == null ? null : json["redeemablePoints"],
    pointsEarned: json["pointsEarned"] == null ? null : json["pointsEarned"],
    pointsRedeemed: json["pointsRedeemed"] == null ? null : json["pointsRedeemed"],
  );

  Map<String, dynamic> toJson() => {
    "redeemablePoints": redeemablePoints == null ? null : redeemablePoints,
    "pointsEarned": pointsEarned == null ? null : pointsEarned,
    "pointsRedeemed": pointsRedeemed == null ? null : pointsRedeemed,
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

  factory RecentRewardTransaction.fromJson(Map<String, dynamic> json) => RecentRewardTransaction(
    id: json["id"] == null ? null : json["id"],
    points: json["points"] == null ? null : json["points"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    typeId: json["typeId"] == null ? null : json["typeId"],
    expiryDate: json["expiryDate"] == null ? null : DateTime.parse(json["expiryDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "points": points == null ? null : points,
    "date": date == null ? null : date!.toIso8601String(),
    "typeId": typeId == null ? null : typeId,
    "expiryDate": expiryDate == null ? null : expiryDate!.toIso8601String(),
  };
}

class Status {
  Status({
    this.code,
    this.message,
  });

  int? code;
  String? message;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
  };
}
