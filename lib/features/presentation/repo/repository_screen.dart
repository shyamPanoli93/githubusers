import 'package:flutter/material.dart';
import 'package:machinetest_skyislimit/features/presentation/home/model/github_repo_model.dart';
import 'package:url_launcher/url_launcher.dart';


class RepositoryTab extends StatelessWidget {
  final List<Repository> repositories;

  RepositoryTab({required this.repositories});

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: repositories.length,
      itemBuilder: (context, index) {
        final repo = repositories[index];
        return ListTile(
          title: Text(repo.name,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          subtitle: Text(repo.description ?? '',style: const TextStyle(color: Colors.blueGrey),),
          onTap: () {
            _launchURL(repo.htmlUrl);
          },
        );
      },
    );
  }
}