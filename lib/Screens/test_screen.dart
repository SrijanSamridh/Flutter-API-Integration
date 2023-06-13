import 'package:flutter/material.dart';

import '../API/controller/test_controller.dart';



class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final controller = TestController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Test Screen')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  controller.getData();
                },
                child: const Text('Get Data'),),
            ElevatedButton(
                onPressed: () async {
                  controller.postData();
                },
                child: const Text('Post Data'),),

          ],
        ),
      ),
    );
  }
}
