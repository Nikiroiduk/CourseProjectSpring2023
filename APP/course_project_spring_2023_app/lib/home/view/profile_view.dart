import 'dart:math';

import 'package:api_repository/api_repository.dart';
import 'package:course_project_spring_2023_app/home/models/models.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../authentication/bloc/authentication_bloc.dart';
import '../home.dart';

class ProfileView extends StatelessWidget {
  Map<String, Widget> images = <String, Widget>{
    "Pull-ups": Image.asset('assets/images/courses/pull-ups.jpg'),
    "Push-ups": Image.asset('assets/images/courses/push-ups.jpg'),
    "Dips": Image.asset('assets/images/courses/dips.jpg'),
    "Burpees": Image.asset('assets/images/courses/burpees.jpg'),
    "Lunges": Image.asset('assets/images/courses/lunges.jpg'),
    "Sit-ups": Image.asset('assets/images/courses/sit-ups.jpg'),
    "Squats": Image.asset('assets/images/courses/squats.jpg'),
  };

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(UpdateUserData(context
        .select((AuthenticationBloc bloc) => bloc.state.user as Person)));
    context.read<HomeBloc>().add(IsNewUserChanged(context
        .select((AuthenticationBloc bloc) => bloc.state.user!.isNewPerson)));
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.isNewUser != current.isNewUser ||
          previous.status != current.status ||
          previous.isDataFieldsValid != current.isDataFieldsValid ||
          previous.courses != current.courses,
      builder: (context, state) {
        return context.select((HomeBloc bloc) => bloc.state.user?.role) ==
                "User"
            ? state.isNewUser
                ? Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12.0, top: 16.0),
                    child: ListView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      children: [
                        Text(
                          "Hi, ${state.user?.username}",
                          style: const TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "We need a little more information about you.",
                        ),
                        const SizedBox(height: 20),
                        _FirstNameInput(),
                        const SizedBox(height: 12),
                        _LastNameInput(),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(child: _HeightInput()),
                            const SizedBox(width: 12),
                            Expanded(child: _WeightInput()),
                          ],
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            hintText: 'Gender',
                          ),
                          items: const [
                            DropdownMenuItem(value: 0, child: Text('Male')),
                            DropdownMenuItem(value: 1, child: Text('Female')),
                          ],
                          onChanged: (value) => context.read<HomeBloc>().add(
                              GenderChanged(value == 0 ? 'Male' : 'Female')),
                        ),
                        const SizedBox(height: 12),
                        DateTimeFormField(
                          firstDate: DateTime.parse('1950-01-01'),
                          lastDate: DateTime.now(),
                          initialDate: DateTime.parse(
                              '${DateTime.now().year - 18}-01-01'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            hintText: 'Birth date',
                          ),
                          mode: DateTimeFieldPickerMode.date,
                          onDateSelected: (value) => context
                              .read<HomeBloc>()
                              .add(BirthDateChanged(value)),
                        ),
                        const SizedBox(height: 12),
                        _SendButton(),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12.0, top: 16.0),
                    child: ListView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      children: [
                        Text(
                          "${context.select((HomeBloc bloc) => bloc.state.user?.username.toUpperCase())}",
                          style: const TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${context.select((HomeBloc bloc) => bloc.state.user?.firstName)} "
                          "${context.select((HomeBloc bloc) => bloc.state.user?.lastName)}",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              letterSpacing: 1.1),
                        ),
                        Text(
                          "${context.select((HomeBloc bloc) => bloc.state.user?.gender)}, "
                          "${context.select((HomeBloc bloc) => bloc.state.user?.age)}",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              letterSpacing: 1.1),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          "Your courses",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: List<Widget>.generate(
                              context.select(
                                  (HomeBloc bloc) => bloc.state.courses.length),
                              (int index) {
                            return GestureDetector(
                              onTap: () async {
                                // var result = await Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => CoursePage(
                                //       course: state.courses[index],
                                //       image: images[state.courses[index].name]
                                //           as Widget,
                                //     ),
                                //   ),
                                // );
                                // Object? tmp = await Future.value(result);
                                // Person p = context.read<HomeBloc>().state.user
                                //     as Person;
                                // if (tmp != null && tmp is Course) {
                                //   p.courses.add(tmp);
                                //   context
                                //       .read<HomeBloc>()
                                //       .add(CoursesChanged(p.courses));
                                //   context.read<HomeBloc>().add(UpsertUser(
                                //       context.read<HomeBloc>().state.user
                                //           as Person));
                                //}
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 14),
                                child: Stack(
                                  fit: StackFit.passthrough,
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    images[state.courses[index].name] as Widget,
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
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(14.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                color: Color.fromARGB(
                                                    225, 255, 255, 255),
                                              ),
                                              clipBehavior: Clip.none,
                                              padding: const EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  top: 4,
                                                  bottom: 4),
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
                          }),
                        ),
                      ],
                    ),
                  )
            : Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('Users list'),
                    Text('Blogs list'),
                    Text('Courses list'),
                  ],
                ),
              );
      },
    );
  }
}

class _FirstNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: ((previous, current) =>
          previous.firstName != current.firstName),
      builder: (context, state) {
        return TextField(
          key: const Key('homePage_firstNameInput'),
          onChanged: (firstName) =>
              context.read<HomeBloc>().add(FirstNameChanged(firstName)),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            labelText: 'First Name',
            errorText: state.firstName.isValid ? null : 'invalid first name',
          ),
        );
      },
    );
  }
}

class _LastNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: ((previous, current) => previous.lastName != current.lastName),
      builder: (context, state) {
        return TextField(
          key: const Key('homePage_lastNameInput'),
          onChanged: (lastName) =>
              context.read<HomeBloc>().add(LastNameChanged(lastName)),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            labelText: 'Last Name',
            errorText: state.lastName.isValid ? null : 'invalid last name',
          ),
        );
      },
    );
  }
}

class _WeightInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: ((previous, current) => previous.weight != current.weight),
      builder: (context, state) {
        return TextField(
          key: const Key('homePage_weightInput'),
          onChanged: (weight) =>
              context.read<HomeBloc>().add(WeightChanged(weight)),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            labelText: 'Weight',
            errorText: state.weight.isValid ? null : 'invalid weight',
          ),
        );
      },
    );
  }
}

class _HeightInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: ((previous, current) => previous.height != current.height),
      builder: (context, state) {
        return TextField(
          key: const Key('homePage_heightInput'),
          onChanged: (height) =>
              context.read<HomeBloc>().add(HeightChanged(height)),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            labelText: 'Height',
            errorText: state.height.isValid ? null : 'invalid height',
          ),
        );
      },
    );
  }
}

class _SendButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.isDataFieldsValid != current.isDataFieldsValid,
      builder: (context, state) {
        return ElevatedButton(
          key: const Key('profileView_continue'),
          onPressed: state.isDataFieldsValid
              ? () {
                  context.read<HomeBloc>().add(const NewUserDataSubmitted());
                }
              : null,
          child: const Padding(
            padding: EdgeInsets.all(18.0),
            child: Text('Send'),
          ),
        );
      },
    );
  }
}
