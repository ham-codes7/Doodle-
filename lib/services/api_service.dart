import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:5000/api';

  // Helper to get headers with JWT token
  static Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // --- Authentication ---

  static Future<Map<String, dynamic>> register(String name, String email, String password, String role) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'role': role,
      }),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> linkPartner(String partnerCode) async {
    final headers = await _getHeaders();
    final response = await http.put(
      Uri.parse('$baseUrl/auth/link'),
      headers: headers,
      body: jsonEncode({'partnerCode': partnerCode}),
    );
    return jsonDecode(response.body);
  }

  // --- Symptom Logs ---

  static Future<Map<String, dynamic>> submitLog(Map<String, dynamic> logData) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$baseUrl/logs'),
      headers: headers,
      body: jsonEncode(logData),
    );
    return jsonDecode(response.body);
  }

  // --- Dashboard ---

  static Future<Map<String, dynamic>> getPartnerDashboard() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/logs/partner/dashboard'),
      headers: headers,
    );
    return jsonDecode(response.body);
  }
}
