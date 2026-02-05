// import 'package:msg91/msg91.dart';

// class Msg91Service {
//   static final Msg91 _msg91 = Msg91().initialize(
//     authKey: "492407AzE1hGroTmq698453deP1",
//   );

//   /// SEND OTP
//   static Future<bool> sendOtp(String mobile) async {
//     try {
//       final formattedMobile = "+91$mobile"; // Correct: no '+'

//       final res = await _msg91.getOtp().send(
//         mobileNumber: formattedMobile,
//         options: OtpOptions(
//           templateId: "6983c5536768b5163830763d", // Approved template
//         ),
//       );

//       print("OTP SEND RESPONSE => $res");

//       // ✅ Fix: res is String ("Success") in latest package
//       return res.toString().toLowerCase() == "success";
//     } catch (e, s) {
//       print("OTP ERROR => $e");
//       print(s);
//       return false;
//     }
//   }

//   /// VERIFY OTP
//   static Future<bool> verifyOtp(String mobile, String otp) async {
//     try {
//       final formattedMobile = "91$mobile";

//       final res = await _msg91.getOtp().verify(
//         mobileNumber: formattedMobile,
//         otp: otp,
//       );

//       print("VERIFY RESPONSE => $res");

//       // ✅ Fix: res may also be String or Map depending on SDK version
//       if (res is String) return res.toLowerCase() == "success";
//       if (res is Map && res['type'] != null) return res['type'] == "success";

//       return false;
//     } catch (e, s) {
//       print("VERIFY ERROR => $e");
//       print(s);
//       return false;
//     }
//   }
// }
