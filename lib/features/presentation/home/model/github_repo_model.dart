class Repository {
  final String name;
  final String description;
  final String htmlUrl;

  Repository({
    required this.name,
    required this.description,
    required this.htmlUrl,
  });
  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      htmlUrl: json['html_url'] ?? '',
    );
  }

}