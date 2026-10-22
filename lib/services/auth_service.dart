import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  // Windows desktop-এ চালালে এই address ব্যবহার করো।
  static const String baseUrl = 'http://localhost:3000';

  static const storage = FlutterSecureStorage();

  static Future<Map<String, dynamic>> register({
    required String huddleId,
    required String displayName,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'huddleId': huddleId,
        'displayName': displayName,
        'email': email,
        'password': password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      await storage.write(key: 'auth_token', value: data['token']);
      return Map<String, dynamic>.from(data['user']);
    }

    throw Exception(data['error'] ?? 'Registration failed');
  }

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      await storage.write(key: 'auth_token', value: data['token']);
      return Map<String, dynamic>.from(data['user']);
    }

    throw Exception(data['error'] ?? 'Login failed');
  }

  static Future<void> logout() async {
    await storage.delete(key: 'auth_token');
  }
}