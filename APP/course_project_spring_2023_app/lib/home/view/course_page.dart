import 'package:api_repository/api_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class CoursePage extends StatelessWidget {
  CoursePage(
      {required Course course,
      required Widget image,
      this.isFromUserPage = false})
      : _course = course,
        _image = image;

  late bool isFromUserPage;
  final Course _course;
  final Widget _image;
  List<int>? _approaches;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isFromUserPage
          ? Container()
          : IconButton(
              icon: const Icon(
                Icons.add_circle_rounded,
                size: 60,
              ),
              onPressed: () {
                Navigator.pop<Course>(context, _course);
              },
            ),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 14),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                clipBehavior: Clip.hardEdge,
                child: Stack(
                  fit: StackFit.passthrough,
                  alignment: Alignment.bottomLeft,
                  children: [
                    _image,
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black45,
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Color.fromARGB(225, 255, 255, 255),
                              ),
                              clipBehavior: Clip.none,
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 4, bottom: 4),
                              child: Text(
                                _course.name,
                                style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              ),
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Text('${_course.exercises.length} exercises'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 10,
                  children: List<Widget>.generate(_course.exercises.length,
                      (int index) {
                    _approaches = _course.exercises[index].approaches;
                    return Column(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Wrap(
                              direction: Axis.vertical,
                              spacing: 12,
                              children: List<Widget>.generate(
                                  _course.exercises[index].approaches.length,
                                  (index) {
                                return index % 2 != 0
                                    ? RichText(
                                        text: TextSpan(
                                            text: 'Timeout: ',
                                            style: const TextStyle(),
                                            children: [
                                            TextSpan(
                                                text: '${_approaches![index]}',
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
                                                text: '${_approaches![index]}',
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
                        ]);
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
