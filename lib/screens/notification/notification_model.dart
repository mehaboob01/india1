// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.data,
    this.status,
  });

  Data? data;
  Status? status;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
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
    this.nextToken,
    this.notifications,
  });

  String? nextToken;
  List<Notification>? notifications;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    nextToken: json["nextToken"] == null ? null : json["nextToken"],
    notifications: json["notifications"] == null ? null : List<Notification>.from(json["notifications"].map((x) => Notification.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "nextToken": nextToken == null ? null : nextToken,
    "notifications": notifications == null ? null : List<dynamic>.from(notifications!.map((x) => x.toJson())),
  };
}

class Notification {
  Notification({
    this.id,
    this.title,
    this.body,
    this.status,
    this.date,
    this.type,
    this.category,
    this.route,
  });

  String? id;
  String? title;
  String? body;
  String? status;
  String? date;
  String? type;
  String? category;
  String? route;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    body: json["body"] == null ? null : json["body"],
    status: json["status"] == null ? null : json["status"],
    date: json["date"] == null ? null : (json["date"]),
    type: json["type"] == null ? null : json["type"],
    category: json["category"] == null ? null : json["category"],
    route: json["route"] == null ? null : json["route"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "body": body == null ? null : body,
    "status": status == null ? null : status,
    "date": date == null ? null : date!,
    "type": type == null ? null : type,
    "category": category == null ? null : category,
    "route": route == null ? null : route,
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
