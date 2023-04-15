import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  const BlogPage(
      {required Blog blog,
      required Widget image,
      required String time,
      super.key})
      : _blog = blog,
        _image = image,
        _time = time;

  final Blog _blog;
  final Widget _image;
  final String _time;

  @override
  Widget build(BuildContext context) {
    var tags = <Widget>[];
    for (var tag in _blog.tags) {
      tags.add(Chip(
        label: Text("${tag.name}\t"),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        backgroundColor: Colors.black38,
      ));
    }
    return Scaffold(
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
                            Wrap(
                              spacing: 6,
                              children: tags,
                            ),
                            Text(
                              _blog.name,
                              style: const TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                            Text('$_time minutes'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _blog.content,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
