import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogManager {
  // show dialog
  void showErrorDialog({String title = 'Error', String description = ''}) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: Get.textTheme.headline6),
              Text(description, style: Get.textTheme.bodyText2),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Ok'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // show toast
  // show loading
  static void showLoading([String? message]) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 8.0),
              Text(message ?? 'Loading...'),
            ],
          ),
        ),
      ),
    );
  }

  // hide loading
  static void hideLoading() {
    if (Get.isDialogOpen ?? false) Get.back();
  }
  // show snackbar
}
