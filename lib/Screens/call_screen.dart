// ignore_for_file: file_names

import 'package:api_integration/Screens/components/app_button.dart';
import 'package:api_integration/other/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../other/base_client.dart';
import '../other/posts.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  var data = 'Call API to see response!';
  // ignore: constant_identifier_names
  static const String KEYNAME = 'token';

  String saveToggle = 'Save';

  @override
  void initState() {
    super.initState();
  }

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
                  data = "Successful Request: \n$response}";
                });
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
                  data = "Successfully Updated: \n$response";
                });
              }),
          AppButton(
              color: Colors.red,
              text: 'Delete',
              icon: Icons.delete,
              onPressed: () async {
                var id = 1;
                var response = await BaseClient()
                    .delete('/posts/$id')
                    .catchError((err) {});
                if (response == null) return;
                setState(() {
                  data = "Successfully Deleted: \n$response";
                });
                // debugPrint(response);
                deleteData();
              }),
          AppButton(
              color: Colors.yellow,
              text: saveToggle,
              icon: Icons.save,
              onPressed: () {
                saveData();
              }),
          AppButton(
              color: const Color.fromARGB(255, 59, 248, 255),
              text: 'Retrieve',
              icon: Icons.save,
              onPressed: () {
                getData();
              }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              data,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void getData() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('csrfToken');
    var auth = prefs.getString('authToken');
    if (token != null) {
      setState(() {
        data =
            "Successfully Retrieved:\nCSRF: $token\nAUTH: $auth\n\n<R E T R I E V E D  F R O M  L O C A L  S T O R A G E>";
      });
    } else {
      setState(() {
        data = "No Data Found!";
      });
    }
  }

  void saveData() async {
    // ignore: body_might_complete_normally_catch_error
    var token = await login().catchError((err) {});
    
    // ignore: unnecessary_null_comparison
    if (token == null) return;
    // var pref = await SharedPreferences.getInstance();
    // pref.setString(KEYNAME, token);
    setState(() {
      data =
          "Successfully Stored: \n\n$token \n\n--- S T O R E D  I N  L O C A L  S T O R A G E ---";
      saveToggle = 'Saved';
    });
  }

  void deleteData() async {
    var pref = await SharedPreferences.getInstance();
    pref.remove(KEYNAME);
    pref.remove('csrfToken');
    pref.remove('authToken');
    setState(() {
      data = "Data: Successfully Deleted!";
    });
  }
}
