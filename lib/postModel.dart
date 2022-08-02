// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
    PostModel({
        required this.post,
        required this.date,
        required this.name
    });

    String post;
    String date;
    String name;

    factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        post: json["post"],
        date: json["date"],
        name: json["name"]
    );

    Map<String, dynamic> toJson() => {
        "post": post,
        "date": date,
        "name": name,
    };
}
