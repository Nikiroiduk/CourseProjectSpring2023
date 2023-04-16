import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home.dart';

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
