import 'package:api_integration/models/post.dart';
import 'package:flutter/material.dart';

import '../services/remote_services.dart';

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
    _fetchPosts();
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
        child: Visibility(
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
                      style: const TextStyle(fontWeight: FontWeight.w300, color: Colors.grey)),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
