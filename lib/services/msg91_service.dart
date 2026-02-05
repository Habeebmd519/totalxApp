import 'package:msg91/msg91.dart';

class Msg91Service {
  // Initialize Msg91 package with your auth key
  static final Msg91 _msg91 = Msg91().initialize(
    authKey: "492407AYK2TDSp69837deaP1",
  );

  /// SEND OTP
  static Future<bool> sendOtp(String mobile) async {
    try {
      final formattedMobile = "+91$mobile";

      final res = await _msg91.getOtp().send(
        mobileNumber: formattedMobile,
        options: OtpOptions(
          templateId: "6983984303655929ab3e1815", // use correct OTP template
        ),
      );

      print("OTP SEND RESPONSE => $res");
      return res.type == "success";
    } catch (e, s) {
      print("OTP ERROR => $e");
      print(s);
      return false;
    }
  }

  /// VERIFY OTP
  static Future<bool> verifyOtp(String mobile, String otp) async {
    try {
      final formattedMobile = "91$mobile";

      final res = await _msg91.getOtp().verify(
        otp: otp,
        mobileNumber: formattedMobile,
      );

      print("VERIFY RESPONSE: $res");

      // The package returns an object with type "success" if OTP is correct
      return res.type == "success";
    } catch (e, s) {
      print("VERIFY ERROR: $e");
      print(s);
      return false;
    }
  }
}
