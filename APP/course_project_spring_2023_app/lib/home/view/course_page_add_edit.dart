import 'package:api_repository/api_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoursePageAddEdit extends StatefulWidget {
  CoursePageAddEdit({this.course});
  late Course? course;
  @override
  State<CoursePageAddEdit> createState() =>
      _CoursePageAddEditState(course: course);
}

class _CoursePageAddEditState extends State<CoursePageAddEdit> {
  _CoursePageAddEditState({this.course});
  final _nameController = TextEditingController();

  late Course? course;

  late List<Exercise> _exercises =
      course == null ? <Exercise>[] : course?.exercises as List<Exercise>;
  String _exercise = '';

  @override
  void initState() {
    //_nameController.text = '';
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            child: const Text('Add new exercise'),
            onPressed: () {
              var dialog = AlertDialog(
                title: const Text('Add new exercise'),
                content: TextField(
                  maxLength: 50,
                  onChanged: (value) => _exercise = value,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      hintText: 'Exercise'),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _exercises.add(Exercise(id: 0, data: _exercise));
                          _exercise = '';
                          Navigator.of(context, rootNavigator: true).pop();
                        });
                      },
                      icon: const Icon(Icons.add)),
                  IconButton(
                      onPressed: () {
                        _exercise = '';
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      icon: const Icon(Icons.close)),
                ],
              );
              showDialog(
                  context: context, builder: (BuildContext context) => dialog);
            },
          ),
          const SizedBox(
            width: 14,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop<Course>(
                    context,
                    Course(
                      id: 0,
                      name: _nameController.text,
                      exercises: _exercises,
                    ));
              },
              child: Text('Add course')),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              maxLength: 50,
              onSubmitted: (value) => _nameController.text = value,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  label: const Text('Course name')),
            ),
            Wrap(
              spacing: 6,
              children: List<Widget>.generate(_exercises.length, (int index) {
                var approaches = _exercises[index].approaches;
                return Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(
                        'Day ${index + 1}',
                        style: const TextStyle(fontSize: 25),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Wrap(
                          direction: Axis.vertical,
                          spacing: 12,
                          children: List<Widget>.generate(
                              _exercises[index].approaches.length, (index) {
                            return index % 2 != 0
                                ? RichText(
                                    text: TextSpan(
                                        text: 'Timeout: ',
                                        style: const TextStyle(),
                                        children: [
                                        TextSpan(
                                            text: '${approaches[index]}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ]))
                                : RichText(
                                    text: TextSpan(
                                        text: 'Set: ',
                                        style: const TextStyle(),
                                        children: [
                                        TextSpan(
                                            text: '${approaches[index]}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ]));
                          }),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ]));
              }),
            ),
          ],
        ),
      ),
    );
  }
}
