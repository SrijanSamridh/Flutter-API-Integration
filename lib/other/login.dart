import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> login() async {
  // Step 1: Get CSRF Token & Cookie
  var (cookie, csrfToken) = await generateCookieString();

  // Step 2: Perform Login
  http.Response response = await http.post(
    Uri.parse('https://hanuven.vercel.app/api/auth/callback/credentials'),
    headers: {'cookie': cookie},
    body: {
      // 'email': 'tripatjot1455.be21@chitkara.edu.in',
      // 'password': 'qwerty12345',
      "phoneNumber": "8708504000",
      "otp": "154558",
      'json': 'true',
      'csrfToken': csrfToken.split('%')[0],
    },
  );

  // Step 3: Save the Cookie
  await saveCookiesToLocalStorage(response.headers['set-cookie']!);
  debugPrint(response.body);
  debugPrint(response.headers['set-cookie']!);
  return response.body;
}

// Function 1: Text to JSON Cookies Converter
Map<String, String> textToJsonCookies(String cookiesText) {
  List<String> cookiesList = cookiesText.split('; ');
  Map<String, String> cookiesMap = {};

  for (String cookie in cookiesList) {
    try {
      List<String> cookieParts = cookie.split('=');
      String key = cookieParts[0];
      String value = cookieParts[1];
      cookiesMap[key] = value;
      // ignore: empty_catches
    } catch (e) {}
  }
  return cookiesMap;
}

// Function 2: CSRF Generator
Future<String> generateCsrf() async {
  http.Response csrfResponse = await http.post(
    Uri.parse('https://hanuven.vercel.app/api/auth/callback/credentials'),
    body: {'json': 'true'},
  );
  String csrfToken = textToJsonCookies(
          csrfResponse.headers['set-cookie']!)['__Host-next-auth.csrf-token']
      .toString();

  var pref = await SharedPreferences.getInstance();
  pref.setString('csrfToken', csrfToken);
  return csrfToken;
}

// Function 3: Cookie String Generator
Future<(String, String)> generateCookieString() async {
  var prefs = await SharedPreferences.getInstance();
  // Get Locally Saved data
  var csrfToken = prefs.getString('csrfToken');
  var authToken = prefs.getString('authToken');

  // Verify Weather the CsrfToken is stored Or Not
  csrfToken ??= await generateCsrf();

  var store = jsonToTextCookies({
    '__Host-next-auth.csrf-token': csrfToken,
    '__Secure-next-auth.session-token': authToken ?? '',
  });
  return (store, csrfToken);
}

// Function 4: Cookie Saver
Future<void> saveCookiesToLocalStorage(String cookieString) async {
  var cookieJson = textToJsonCookies(cookieString);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    await prefs.setString(
        'csrfToken', cookieJson['__Host-next-auth.csrf-token']!);
  } catch (e) {
    // debugPrint(e.toString());
  }
  debugPrint(cookieJson.toString());
  try {
    await prefs.setString(
        'authToken', cookieJson['__Secure-next-auth.session-token']!);
  } catch (e) {
    // debugPrint(e.toString());
  }
}

// Function 5: Json to Text Cookies Converter
String jsonToTextCookies(Map<String, String> cookiesMap) {
  String cookiesText = '';
  for (String? key in cookiesMap.keys) {
    // if value is null, skip
    if (cookiesMap[key] == '') continue;
    String value = cookiesMap[key]!;
    cookiesText += '$key=$value; ';
  }
  return cookiesText;
}

// Function 6: Get Csrftoken from Local Storage
Future<String> getCsrfToken() async {
  var prefs = await SharedPreferences.getInstance();
  var csrfToken = prefs.getString('csrfToken');
  csrfToken ??= await generateCsrf();
  return csrfToken;
}
