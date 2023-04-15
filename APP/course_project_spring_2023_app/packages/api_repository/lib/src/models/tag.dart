class Tag {
  const Tag({required this.id, required this.name});

  final int id;
  final String name;

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(id: json['Id'], name: json['Name']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "Name": name,
    };
  }

  @override
  String toString() {
    return "Id: $id, Name: $name";
  }
}
