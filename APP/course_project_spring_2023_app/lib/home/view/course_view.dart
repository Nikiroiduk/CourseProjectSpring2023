import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../authentication/bloc/authentication_bloc.dart';
import '../bloc/course/course_bloc.dart';
import '../home.dart';

class CourseView extends StatefulWidget {
  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
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
        create: (_) => CourseBloc(apiRepository: _apiRepository),
        child: _Courses(),
      ),
    );
  }
}

Map<String, Widget> images = <String, Widget>{
  "Pull-ups": Image.asset('assets/images/courses/pull-ups.jpg'),
  "Push-ups": Image.asset('assets/images/courses/push-ups.jpg'),
  "Dips": Image.asset('assets/images/courses/dips.jpg'),
  "Burpees": Image.asset('assets/images/courses/burpees.jpg'),
  "Lunges": Image.asset('assets/images/courses/lunges.jpg'),
  "Sit-ups": Image.asset('assets/images/courses/sit-ups.jpg'),
  "Squats": Image.asset('assets/images/courses/squats.jpg'),
};

class _Courses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<CourseBloc>().add(TokenChangedCourse(
        context.read<AuthenticationBloc>().state.user!.token));
    return BlocBuilder<CourseBloc, CourseState>(
      buildWhen: (previous, current) => previous.courses != current.courses,
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 45.0, left: 10, right: 10, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text('COURSES',
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
                                      builder: (context) => CoursePageAddEdit(),
                                    ),
                                  );
                                  Object? tmp = await Future.value(result);
                                  if (tmp != null) {
                                    var _course = tmp as Course;
                                    context
                                        .read<CourseBloc>()
                                        .add(CourseAdded(_course));
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
                itemCount: state.courses.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      var result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CoursePage(
                            course: state.courses[index],
                            image: images[state.courses[index].name] as Widget,
                          ),
                        ),
                      );
                      Object? tmp = await Future.value(result);
                      Person p = context.read<HomeBloc>().state.user as Person;
                      if (tmp != null && tmp is Course) {
                        var c = p.courses;
                        c.add(tmp);
                        context.read<HomeBloc>().add(CoursesChanged(c));
                        context.read<HomeBloc>().add(UpsertUser(
                            context.read<HomeBloc>().state.user as Person));
                      }
                    },
                    onDoubleTap: () {
                      context.read<HomeBloc>().state.user!.role == 'Admin'
                          ? context
                              .read<CourseBloc>()
                              .add(CourseRemoved(state.courses[index]))
                          : () {};
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      // decoration: const BoxDecoration(
                      //   borderRadius: BorderRadius.all(Radius.circular(10)),
                      // ),
                      //clipBehavior: Clip.hardEdge,
                      child: Stack(
                        fit: StackFit.passthrough,
                        alignment: Alignment.bottomLeft,
                        children: [
                          images[state.courses[index].name] as Widget,
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
                                      state.courses[index].name,
                                      style: const TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                      '${state.courses[index].exercises.length} exercises'),
                                ],
                              ),
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
      },
    );
  }
}
