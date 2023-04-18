import 'dart:math';

import 'package:api_repository/api_repository.dart';
import 'package:course_project_spring_2023_app/authentication/bloc/authentication_bloc.dart';
import 'package:course_project_spring_2023_app/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home.dart';

class BlogView extends StatefulWidget {
  @override
  State<BlogView> createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
  late final _apiRepository;

  @override
  void initState() {
    _apiRepository = ApiRepository();
    super.initState();
  }

  @override
  void dispose() {
    _apiRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _apiRepository,
      child: BlocProvider(
        create: (_) => BlogBloc(apiRepository: _apiRepository),
        child: _Blogs(),
      ),
    );
  }
}

class _Blogs extends StatelessWidget {
  _Blogs();
  var images = <Widget>[
    Image.asset(
      'assets/images/fitness.jpg',
    ),
    Image.asset(
      'assets/images/football.jpg',
    ),
    Image.asset(
      'assets/images/health.jpg',
    ),
    Image.asset(
      'assets/images/push-ups.jpg',
    ),
    Image.asset(
      'assets/images/run.jpg',
    ),
    Image.asset(
      'assets/images/swimming.jpg',
    ),
  ];

  var times = <String>[];
  late Blog _blog;
  @override
  Widget build(BuildContext context) {
    for (var blog in context.read<BlogBloc>().state.blogs) {
      times.add((Random().nextInt(19) + 3).toString());
    }
    if (context.read<AuthenticationBloc>().state.user != null) {
      context.read<BlogBloc>().add(
          TokenChanged(context.read<AuthenticationBloc>().state.user!.token));
    }
    return BlocBuilder<BlogBloc, BlogState>(
      buildWhen: (previous, current) =>
          previous.blogs != current.blogs || previous.added != current.added,
      builder: ((context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 45.0, left: 10, right: 10, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text('BLOGS',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  ),
                  context.read<AuthenticationBloc>().state.user!.role == 'Admin'
                      ? Row(
                          children: [
                            IconButton(
                                onPressed: () async {
                                  var result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlogPageAddEdit(),
                                    ),
                                  );
                                  Object? tmp = await Future.value(result);
                                  if (tmp != null) {
                                    _blog = tmp as Blog;
                                    context
                                        .read<BlogBloc>()
                                        .add(BlogAdded(_blog));
                                  }
                                },
                                icon: const Icon(Icons.add_box_rounded))
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: state.blogs.length,
                itemBuilder: (context, index) {
                  var tags = <Widget>[];
                  for (var tag in state.blogs[index].tags) {
                    tags.add(Chip(
                      label: Text("${tag.name}\t"),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      backgroundColor: Colors.black38,
                    ));
                  }
                  return GestureDetector(
                    onTap: () async {
                      if (context.read<AuthenticationBloc>().state.user!.role ==
                          'Admin') {
                        var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BlogPageAddEdit(blog: state.blogs[index]),
                          ),
                        );
                        Object? tmp = await Future.value(result);
                        if (tmp != null) {
                          _blog = await Future.value(result);
                          context.read<BlogBloc>().add(BlogUpdated(_blog));
                        }
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlogPage(
                                blog: state.blogs[index],
                                time: times[index],
                                image: index >= images.length
                                    ? images[index - images.length]
                                    : images[index]),
                          ),
                        );
                      }
                    },
                    onDoubleTap: () {
                      context.read<HomeBloc>().state.user!.role == 'Admin'
                          ? context
                              .read<BlogBloc>()
                              .add(BlogDeleted(state.blogs[index]))
                          : () {};
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      // decoration: const BoxDecoration(
                      //   borderRadius: BorderRadius.all(Radius.circular(10)),
                      // ),
                      // clipBehavior: Clip.hardEdge,
                      child: Stack(
                        fit: StackFit.passthrough,
                        alignment: Alignment.bottomLeft,
                        children: [
                          //trash
                          index >= images.length
                              ? images[index - images.length]
                              : images[index],
                          Container(
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black45,
                              ],
                            )),
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
                                      state.blogs[index].name,
                                      style: const TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    index >= 0 && times.isNotEmpty
                                        ? Text('${times[index]} minutes')
                                        : Container(),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
