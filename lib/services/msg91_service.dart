import 'dart:convert';
import 'package:http/http.dart' as http;

class Msg91Service {
  static const String _authKey = "492407AzE1hGroTmq698453deP1";
  static const String _templateId = "6984fa114ca1922e27175672";

  /// SEND OTP
  static Future<bool> sendOtp(String mobile) async {
    try {
      final response = await http.post(
        Uri.parse("https://control.msg91.com/api/v5/otp"),
        headers: {"Content-Type": "application/json", "authkey": _authKey},
        body: jsonEncode({
          "template_id": _templateId,
          "mobile": "91$mobile",
          "otp_expiry": 5,
        }),
      );

      print("📤 SEND OTP RESPONSE => ${response.body}");

      final data = jsonDecode(response.body);
      return data["type"] == "success";
    } catch (e) {
      print("❌ SEND OTP ERROR => $e");
      return false;
    }
  }

  /// VERIFY OTP
  static Future<bool> verifyOtp(String mobile, String otp) async {
    try {
      final response = await http.post(
        Uri.parse("https://control.msg91.com/api/v5/otp/verify"),
        headers: {"Content-Type": "application/json", "authkey": _authKey},
        body: jsonEncode({"mobile": "91$mobile", "otp": otp}),
      );

      print("📥 VERIFY OTP RESPONSE => ${response.body}");

      final data = jsonDecode(response.body);
      return data["type"] == "success";
    } catch (e) {
      print("❌ VERIFY OTP ERROR => $e");
      return false;
    }
  }
}
