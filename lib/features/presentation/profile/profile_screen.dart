import 'package:flutter/material.dart';

import '../home/model/github_user_details_model.dart';

class ProfileTab extends StatelessWidget {
  final GitHubUserData userData;

  ProfileTab({required this.userData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(userData.avatarUrl),
            ),
            const SizedBox(height: 20),
            Text(
              '${userData.username}',
              style: Theme.of(context).textTheme.headline3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Repositories',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${userData.publicRepos}',
                    style: const TextStyle(color: Colors.white,fontSize: 12),
                  ),
                )
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  userData.userBio,
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
