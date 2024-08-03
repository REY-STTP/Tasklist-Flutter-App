import 'dart:convert';

class TaskResponseModel {
    final String id;
    final String title;
    final String description;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    TaskResponseModel({
        required this.id,
        required this.title,
        required this.description,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory TaskResponseModel.fromRawJson(String str) => TaskResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TaskResponseModel.fromJson(Map<String, dynamic> json) => TaskResponseModel(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}