import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:machinetest_skyislimit/features/presentation/home/model/github_repo_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/github_user_details_model.dart';

part 'github_state.dart';

class GithubCubit extends Cubit<GithubState> {
  GithubCubit() : super(GithubInitial());

  Future<void> searchUser(String username) async {
    emit(GitHubLoading());
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        emit(GitHubNetworkError('No internet connection'));
        return;
      }

      final response =
          await http.get(Uri.parse('https://api.github.com/users/$username'));
      final reposResponse = await http
          .get(Uri.parse('https://api.github.com/users/$username/repos'));
      if (response.statusCode == 200 && reposResponse.statusCode == 200) {
        final userData = jsonDecode(response.body);
        final user = GitHubUserData.fromJson(userData);
        print("ResponseDetails:----$user");
        final List<dynamic> repoData = jsonDecode(reposResponse.body);
        final List<Repository> repositories = repoData.map((repo) => Repository.fromJson(repo)).toList();
        print("RepoDetails:----${repositories.toList()}");
        emit(GitHubUserLoaded(userData: user, repositories: repositories));
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      emit(GitHubError('Error: $e'));
    }
  }
}
