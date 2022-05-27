import 'dart:convert';

class ResponseJsonModel {
  final String title;

  final String value;
  ResponseJsonModel({
    required this.title,
    required this.value,
  });

  factory ResponseJsonModel.fromJson(String str) =>
      ResponseJsonModel.fromMap(json.decode(str));

  factory ResponseJsonModel.fromMap(Map<String, dynamic> json) =>
      ResponseJsonModel(
        title: json["title"],
        value: json["value"],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "title": title,
        "value": value,
      };
}
