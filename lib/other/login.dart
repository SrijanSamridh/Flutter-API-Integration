import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<String> login() async {

  // Step 1: Fetch CSRF Token
  http.Response csrfResponse = await http.post(
    Uri.parse(
        'https://enablerz-production.vercel.app/api/auth/callback/credentials'),
    body: {'json': 'true'},
  );
  String csrfToken =
      csrfResponse.headers['set-cookie']!.split(';')[0].split('=')[1];

  // Step 2: Perform Login
  http.Response response = await http.post(
    Uri.parse(
        'https://enablerz-production.vercel.app/api/auth/callback/credentials'),
    headers: {'cookie': '__Host-next-auth.csrf-token=$csrfToken;'},
    body: {
      'email': 'tripatjot1455.be21@chitkara.edu.in',
      'password': 'qwerty12345',
      'json': 'true',
      'csrfToken': csrfToken.split('%')[0],
    },
  );

  // Step 3: Store response headers in local storage using Hive
  


  debugPrint(csrfToken);
  debugPrint(response.headers['set-cookie']!.split(';')[4].split('=')[2]);
  return response.headers['set-cookie']!.split(';')[4].split('=')[2];
}
