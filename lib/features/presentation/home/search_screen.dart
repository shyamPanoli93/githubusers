import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machinetest_skyislimit/features/presentation/home/cubit/github_cubit.dart';

import '../profile/profile_screen.dart';
import '../repo/repository_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKey = GlobalKey<FormState>();
  var autoValidate = AutovalidateMode.disabled;
  final TextEditingController _usernameController = TextEditingController();
  String _username = '';

  void searchUser() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      FocusManager.instance.primaryFocus?.unfocus();
      _username = _usernameController.text.trim();
      if (_username.isNotEmpty) {
        context.read<GithubCubit>().searchUser(_username);
      }
    } else {
      setState(() {
        autoValidate = AutovalidateMode.onUserInteraction;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('GitHub User Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: autoValidate,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration:
                    const InputDecoration(labelText: 'Enter GitHub Username'),
                onChanged: (value) {
                  setState(() {
                    _username = value.trim();
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter text';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => searchUser(),
                child: const Text('Search'),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(child: BlocBuilder<GithubCubit, GithubState>(
                builder: (context, state) {
                  if (state is GitHubLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GitHubNetworkError) {
                    return Center(child: Text(state.networkErrorMessage));
                  } else if (state is GitHubError) {
                    return Center(child: Text(state.message));
                  } else {
                    return state is GitHubUserLoaded
                        ? Expanded(
                            child: DefaultTabController(
                              length: 2,
                              child: Scaffold(
                                appBar: const TabBar(
                                  tabs: [
                                    Tab(
                                      text: 'Profile',
                                    ),
                                    Tab(
                                      text: 'Repositories',
                                    )
                                  ],
                                ),
                                body: TabBarView(
                                  children: [
                                    ProfileTab(userData: state.userData),
                                    RepositoryTab(
                                      repositories: state.repositories,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const SizedBox
                            .shrink(); // Placeholder for initial state
                  }
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
