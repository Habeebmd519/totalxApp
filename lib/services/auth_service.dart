import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  // ⚠️ Android emulator uses 10.0.2.2 instead of localhost
  static const String baseUrl = "http://192.168.29.225:3000";

  static Future<bool> sendOtp(String mobile) async {
    try {
      print("📤 SEND OTP CALLED FROM FLUTTER");
      print("📤 Mobile: $mobile");
      print("📤 URL: $baseUrl/send-otp");

      final response = await http.post(
        Uri.parse("$baseUrl/send-otp"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"mobile": mobile}),
      );

      print("📥 RESPONSE STATUS: ${response.statusCode}");
      print("📥 RESPONSE BODY: ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("❌ SEND OTP ERROR: $e");
      return false;
    }
  }

  static Future<bool> verifyOtp(String mobile, String otp) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/verify-otp"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"mobile": mobile, "otp": otp}),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("VERIFY OTP ERROR: $e");
      return false;
    }
  }
}
