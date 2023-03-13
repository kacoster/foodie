import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class APIService {
  static const String _baseUrl = "localhost:3000";

  Future<dynamic> get({
    required String endpoint,
    required Map<String, String> query,
  }) async {
    var uri = Uri.http(_baseUrl, endpoint, query);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final error =
          jsonDecode(response.body)['error'] ?? 'Failed to load JSON data';
      throw APIException(response.statusCode, error);
    }
  }

  Future<int> updateDish(String endpoint, Map<String, dynamic> data) async {
    var uri = Uri.http(_baseUrl, endpoint);

    final response = await http.put(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      },
      body: json.encode(data),
    );

    return response.statusCode;
  }

  Future<int> put(
      {required String endpoint, required Map<String, dynamic> mdl}) async {
    var uri = Uri.http(_baseUrl, endpoint);

    var data = json.encode(mdl);

    final response = await http.put(uri, body: data);

    return response.statusCode;
  }

  Future<dynamic> getSku(String endpoint) async {
    var uri = Uri.http(_baseUrl, endpoint);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final error =
          jsonDecode(response.body)['error'] ?? 'Failed to load JSON data';
      throw APIException(response.statusCode, error);
    }
  }

  Future<int> deleteDish(String endpoint, Map<String, dynamic> data) async {
    var uri = Uri.http(_baseUrl, endpoint);

    final response = await http.delete(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      },
      body: json.encode(data),
    );

    return response.statusCode;
  }
}

class APIException implements Exception {
  final int statusCode;
  final String message;

  APIException(this.statusCode, this.message);
}





/*import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class APIService {
  static const String _baseUrl = "localhost:3000";

  Future<dynamic> get({
    required String endpoint,
    required Map<String, String> query,
  }) async {
    var uri = Uri.http(_baseUrl, endpoint, query);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Status FAILED");
      throw Exception('Failed to load JSON data');
    }
  }

  updateDish(String endpoint, Map<String, dynamic> data) async {
    var uri = Uri.http(_baseUrl, endpoint);

    await http
        .put(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      },
      body: json.encode(data),
    )
        .then((response) {
      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        return response.statusCode;
      }
    }).catchError((error) {
      print('Error occurred during PUT request: $error');
      return ('$error');
    });
  }

  put({required String endpoint, required Map<String, dynamic> mdl}) async {
    var uri = Uri.http(_baseUrl, endpoint);

    print(mdl.toString());

    var data = json.encode(mdl);

    await http.put(uri, body: data).then((response) {
      if (response.statusCode == 200) {
        print('PUT request succeeded');
        return response.statusCode;
      } else {
        print('PUT request failed with status: ${response.statusCode}.');
        return response.statusCode;
      }
    }).catchError((error) {
      print('Error occurred during PUT request: $error');
      return ('$error');
    });
  }
}*/
