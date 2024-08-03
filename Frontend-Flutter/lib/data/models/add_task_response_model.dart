import 'dart:convert';

class AddTaskResponseModel {
    final String title;
    final String description;
    final String id;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    AddTaskResponseModel({
        required this.title,
        required this.description,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory AddTaskResponseModel.fromRawJson(String str) => AddTaskResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AddTaskResponseModel.fromJson(Map<String, dynamic> json) => AddTaskResponseModel(
        title: json["title"],
        description: json["description"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}