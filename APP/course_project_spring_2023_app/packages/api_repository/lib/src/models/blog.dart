import 'dart:convert';

import 'models.dart';

class Blog {
  Blog({
    required this.id,
    required this.name,
    required this.content,
    required this.tags,
  });

  int id;
  String name;
  String content;
  List<Tag> tags;

  factory Blog.fromJson(Map<String, dynamic> json) {
    List<Tag> result = <Tag>[];
    for (var element in json['Tags']) {
      if (element is Map<String, dynamic>) result.add(Tag.fromJson(element));
    }
    return Blog(
      id: json['Id'],
      name: json['Name'],
      content: json['Content'],
      tags: result,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> res = <Map<String, dynamic>>[];
    for (var element in tags) {
      res.add(element.toJson());
    }

    print(res);

    return <String, dynamic>{
      "Name": name,
      "Content": content,
      "Tags": res,
    };
  }

  @override
  String toString() {
    return "\nId: $id, Name: $name, Content: $content";
  }
}
