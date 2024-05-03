class GitHubUserData {
  final String username;
  final String avatarUrl;
  final String userBio;
  final int publicRepos;

  GitHubUserData({
    required this.username,
    required this.avatarUrl,
    required this.userBio,
    required this.publicRepos,
  });

  factory GitHubUserData.fromJson(Map<String, dynamic> json) {
    return GitHubUserData(
      username: json['login'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      publicRepos: json['public_repos'] ?? 0,
      userBio: json['bio'] ?? ''
    );
  }
}