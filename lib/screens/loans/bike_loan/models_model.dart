import 'dart:convert';

TwoWheelerModels twoWheelerModelsFromJson(String str) =>
    TwoWheelerModels.fromJson(json.decode(str));

String twoWheelerModelsToJson(TwoWheelerModels data) =>
    json.encode(data.toJson());

class TwoWheelerModels {
  TwoWheelerModels({
    this.models,
  });

  List<String>? models;

  factory TwoWheelerModels.fromJson(Map<String, dynamic> json) =>
      TwoWheelerModels(
        models: json["models"] == null
            ? null
            : List<String>.from(json["models"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "models":
            models == null ? null : List<dynamic>.from(models!.map((x) => x)),
      };
}
