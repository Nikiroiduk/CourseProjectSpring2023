import 'package:api_repository/api_repository.dart';
import 'package:course_project_spring_2023_app/home/models/models.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../authentication/bloc/authentication_bloc.dart';
import '../home.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(UpdateUserData(context
        .select((AuthenticationBloc bloc) => bloc.state.user as Person)));
    context.read<HomeBloc>().add(IsNewUserChanged(context
        .select((AuthenticationBloc bloc) => bloc.state.user!.isNewPerson)));
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => previous.isNewUser != current.isNewUser,
      builder: (context, state) {
        switch (state.isNewUser) {
          case true:
            return Padding(
              padding:
                  const EdgeInsets.only(left: 12.0, right: 12.0, top: 10.0),
              child: ListView(
                physics: const BouncingScrollPhysics(),
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
                    onChanged: (value) => context
                        .read<HomeBloc>()
                        .add(GenderChanged(value == 0 ? 'Male' : 'Female')),
                  ),
                  const SizedBox(height: 12),
                  DateTimeFormField(
                    firstDate: DateTime.parse('1950-01-01'),
                    lastDate: DateTime.now(),
                    initialDate:
                        DateTime.parse('${DateTime.now().year - 18}-01-01'),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      hintText: 'Birth date',
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    onDateSelected: (value) =>
                        context.read<HomeBloc>().add(BirthDateChanged(value)),
                  ),
                  _SendButton(),
                ],
              ),
            );
          case false:
            return const Text('Mock');
          default:
            return const Text('Something went wrong');
        }
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
          //previous.status != current.status ||
          previous.isDataFieldsValid != current.isDataFieldsValid,
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('profileView_continue'),
                onPressed: state.isDataFieldsValid
                    ? () {
                        context
                            .read<HomeBloc>()
                            .add(const NewUserDataSubmitted());
                      }
                    : null,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Send'),
                ),
              );
      },
    );
  }
}
