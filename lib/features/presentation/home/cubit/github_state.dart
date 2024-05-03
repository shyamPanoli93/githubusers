part of 'github_cubit.dart';

@immutable
sealed class GithubState {}

final class GithubInitial extends GithubState {}

class GitHubLoading extends GithubState {}

class GitHubNetworkError extends GithubState {
  final String networkErrorMessage;
  GitHubNetworkError(this.networkErrorMessage);
}

class GitHubError extends GithubState {
  final String message;
  GitHubError(this.message);
}

class GitHubUserLoaded extends GithubState {
  final GitHubUserData userData;
  final List<Repository> repositories;
  GitHubUserLoaded({required this.userData, required this.repositories});
}