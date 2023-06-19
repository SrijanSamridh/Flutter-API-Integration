// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:http/http.dart' as http;

const String baseUrl = 'https://jsonplaceholder.typicode.com';
// const String baseUrl = 'https://hanuven.vercel.app/api/auth/phonenumber';

class BaseClient {
  var client = http.Client();

  // Get request code snippet
  Future<dynamic> get(String api) async {
    var url = Uri.parse(baseUrl + api);
    // ignore: unused_local_variable,
    var _headers = {
      'Authorization': 'Bearer',
      'Accept': 'application/json',
    };
    var response = await client.get(url); // header is optional
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  // Post request code snippet
  Future<dynamic> post(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var _payload = json.encode(object);
    // ignore: unused_local_variable,
    var _headers = {
      'Authorization': 'Bearer',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await client.post(url, body: _payload); // header is optional
    if (response.statusCode == 201) {
      return response.body;
    } else {
      return null;
    }
  }

  // Put request code snippet
  Future<dynamic> put(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var _payload = json.encode(object);
    // ignore: unused_local_variable,
    var _headers = {
      'Authorization': 'Bearer',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await client.put(url, body: _payload); // header is optional
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  // Delete request code snippet
  Future<dynamic> delete(String api) async {
    var url = Uri.parse(baseUrl + api);
    // ignore: unused_local_variable,
    var _headers = {
      'Authorization': 'Bearer',
      'Accept': 'application/json',
    };
    var response = await client.delete(url); // header is optional
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }
}
