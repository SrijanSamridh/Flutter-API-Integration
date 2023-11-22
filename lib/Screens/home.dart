import 'package:api_integration/Screens/components/app_button.dart';
import 'package:flutter/material.dart';

import '../API/models/post.dart';
import '../API/services/remote_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Post>? posts;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
  }

  _fetchPosts() async {
    posts = await RemoteServices.fetchPost();
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Center(
          child: Text('Home'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AppButton(
              color: isLoaded == false? Colors.deepPurpleAccent : const Color.fromARGB(255, 212, 197, 255),
              text:  isLoaded == false? 'API CALL': 'Disabled',
              icon: Icons.api,
              onPressed: () {
                Navigator.pushNamed(context, '/call');
              },
            ),
            AppButton(
              color: Colors.deepPurpleAccent,
              text: 'Fetch Data',
              icon: Icons.api,
              onPressed: () {
                _fetchPosts();
              },
            ),
            const Spacer(),
            Visibility(
              visible: isLoaded,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: ListView.builder(
                itemCount: posts?.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        posts?[index].title.toUpperCase() ?? 'Title',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(posts?[index].body ?? 'Body',
                          style: const TextStyle(
                              fontWeight: FontWeight.w300, color: Colors.grey)),
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
