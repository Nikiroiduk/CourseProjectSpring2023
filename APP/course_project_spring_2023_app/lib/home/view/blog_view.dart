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

  @override
  Widget build(BuildContext context) {
    context.read<BlogBloc>().add(
        TokenChanged(context.read<AuthenticationBloc>().state.user!.token));
    return BlocBuilder<BlogBloc, BlogState>(
      buildWhen: (previous, current) => previous.blogs != current.blogs,
      builder: ((context, state) {
        return ListView.builder(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemCount: state.blogs.length,
          itemBuilder: (context, index) {
            var tags = <Widget>[];
            for (var tag in state.blogs[index].tags) {
              tags.add(Chip(label: Text("${tag.name}\t")));
            }
            return Container(
              margin: EdgeInsets.only(bottom: 14),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              clipBehavior: Clip.hardEdge,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  //trash
                  index >= images.length
                      ? images[index - images.length]
                      : images[index],
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    color: Color.fromARGB(154, 158, 158, 158),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              state.blogs[index].name,
                              style: const TextStyle(
                                  fontSize: 30, shadows: <Shadow>[BoxShadow()]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
            // ListTile(
            //   title: Text(
            //     state.blogs[index].name,
            //     style: const TextStyle(fontSize: 30),
            //   ),
            //   subtitle: Wrap(
            //     spacing: 6,
            //     children: tags,
            //   ),
            // );
          },
        );
      }),
    );
  }
}
