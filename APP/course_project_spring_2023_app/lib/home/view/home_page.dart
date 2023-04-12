import 'package:api_repository/api_repository.dart';
import 'package:course_project_spring_2023_app/authentication/bloc/authentication_bloc.dart';
import 'package:course_project_spring_2023_app/home/bloc/home_bloc.dart';
import 'package:course_project_spring_2023_app/home/view/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeBloc bloc) => bloc.state.value);
    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: [
          BlogView(),
          CourseView(),
          ProfileView(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 4.0,
            bottom: 8.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              _HomeTabButton(
                groupValue: selectedTab,
                value: HomeTab.blog,
                icon: const Icon(Icons.newspaper_rounded),
                label: "Blogs",
              ),
              const SizedBox(),
              _HomeTabButton(
                groupValue: selectedTab,
                value: HomeTab.course,
                icon: const Icon(Icons.sports_outlined),
                label: "Courses",
              ),
              const SizedBox(),
              _HomeTabButton(
                groupValue: selectedTab,
                value: HomeTab.profile,
                icon: const Icon(Icons.person),
                label: "Profile",
              ),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     actions: [
    //       IconButton(
    //         onPressed: () {
    //           context
    //               .read<AuthenticationBloc>()
    //               .add(AuthenticationLogoutRequested());
    //         },
    //         icon: const Icon(Icons.logout_rounded),
    //       ),
    //     ],
    //     title: Builder(
    //       builder: (context) {
    //         final username = context.select(
    //           (AuthenticationBloc bloc) => bloc.state.user?.username,
    //         );
    //         return Text('$username');
    //       },
    //     ),
    //   ),
    //   body: Center(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         BlocBuilder<AuthenticationBloc, AuthenticationState>(
    //           buildWhen: (previous, current) =>
    //               previous.user?.role != current.user?.role ||
    //               previous.user?.isNewPerson != current.user?.isNewPerson,
    //           builder: (context, state) {
    //             switch (state.user?.role) {
    //               case 'Admin':
    //                 return const Text('Current person is Admin');
    //               case 'User':
    //                 return const Text('Current person is User');
    //               default:
    //                 return const Text('Something went wrong');
    //             }
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    //   bottomNavigationBar: BottomNavigationBar(
    //     items: const [
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.newspaper_rounded),
    //         label: 'Blog',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.person_outline),
    //         label: 'Course',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.settings_outlined),
    //         label: 'Settigns',
    //       ),
    //     ],
    //   ),
    // );
  }
}

class BlogView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Blogs'),
    );
  }
}

class CourseView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Course'),
    );
  }
}

class _HomeTabButton extends StatelessWidget {
  const _HomeTabButton({
    required this.groupValue,
    required this.value,
    required this.icon,
    required this.label,
  });

  final HomeTab groupValue;
  final HomeTab value;
  final Widget icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () =>
              context.read<HomeBloc>().add(NewScreenSelected(value)),
          iconSize: 28,
          color: groupValue != value
              ? null
              : Theme.of(context).colorScheme.secondary,
          icon: icon,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: groupValue != value
                ? null
                : Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
