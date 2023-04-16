class Exercise {
  Exercise({required this.id, required this.data});

  final int id;
  final String data;
  late List<int> approaches = _getApproaches();

  List<int> _getApproaches() {
    var l = data.split(',');
    var cool = <int>[];
    for (var i = 0; i < l.length; i++) {
      cool.add(int.parse(l[i]));
    }
    return cool;
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(id: json['Id'], data: json['Data']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "Id": id,
      "Data": data,
    };
  }

  @override
  String toString() {
    return "\nId: $id, Data: $data";
  }
}
