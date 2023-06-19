// ignore_for_file: file_names
import 'package:api_integration/Screens/components/app_button.dart';
import 'package:api_integration/other/login.dart';
import 'package:flutter/material.dart';
import '../other/base_client.dart';
import '../other/posts.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  var data = 'Call Screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Center(
          child: Text('Api Integration'.toUpperCase()),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          AppButton(
              color: Colors.green,
              text: 'get',
              icon: Icons.get_app_rounded,
              onPressed: () async {
                var response =
                    await BaseClient().get('/posts').catchError((err) {});
                if (response == null) return;
                setState(() {
                  data = "Successful Response: \n$response";
                });
                // print count of posts
                var posts = postFromJson(response);
                debugPrint(posts.length.toString());
              }),
          AppButton(
              color: Colors.blue,
              text: 'post',
              icon: Icons.post_add_rounded,
              onPressed: () async {
                var post = Post(
                  userId: 1,
                  id: 1,
                  title: 'title',
                  body: 'body',
                );
                var response = await BaseClient()
                    .post('/posts', post)
                    .catchError((err) {});
                if (response == null) return;
                setState(() {
                  data = "Successful Request: \n$response";
                });
                login();
              }),
          AppButton(
              color: Colors.orange,
              text: 'put',
              icon: Icons.update,
              onPressed: () async {
                var id = 1;
                var post = Post(
                  userId: 1,
                  id: 1,
                  title: 'title1',
                  body: 'body',
                );
                var response = await BaseClient()
                    .put('/posts/$id', post)
                    .catchError((err) {});
                if (response == null) return;
                setState(() {
                  data = "Successful Updated: \n$response";
                });
              }),
          AppButton(
              color: Colors.red,
              text: 'Del',
              icon: Icons.delete,
              onPressed: () async {
                var id = 1;
                var response = await BaseClient()
                    .delete('/posts/$id')
                    .catchError((err) {});
                if (response == null) return;
                setState(() {
                  data = "Successful Deleted: \n$response";
                });
                debugPrint(response);
              }),
          Text(
            data,
            style: const TextStyle(fontSize: 15),
          ),
        ]),
      ),
    );
  }
}
