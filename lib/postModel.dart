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
    });

    String post;
    String date;

    factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        post: json["post"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "post": post,
        "date": date,
    };
}
