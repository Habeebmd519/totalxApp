import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:totelxapp/screens/home_screen.dart';
import 'package:totelxapp/services/auth_service.dart';
import 'package:totelxapp/services/msg91_service.dart';
// import 'package:totelxapp/widgets/primery_button.dart';
import 'otp_screen.dart';
// import '../widgets/primary_button.dart';
import '../widgets/primery_button.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Image.asset("assets/login.png", height: 120),
            const SizedBox(height: 30),
            Align(
              alignment: AlignmentGeometry.topLeft,
              child: Text(
                "Enter Phone Number",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  height: 1.0, // 100%
                  letterSpacing: 0,
                  color: Color(0xFF333333),
                ),
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hint: Text(
                  "Enter Phone Number",
                  style: GoogleFonts.montserrat(color: Colors.grey),
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.2),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                ),
              ),
            ),

            const SizedBox(height: 20),
            Align(
              alignment: AlignmentGeometry.topLeft,
              child: RichText(
                text: TextSpan(
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: const Color(0xFF333333),
                  ),
                  children: [
                    const TextSpan(text: "By Continuing, I agree to TotalX’s "),

                    TextSpan(
                      text: "Terms and Conditions",
                      style: GoogleFonts.montserrat(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => print("Terms clicked"),
                    ),

                    const TextSpan(text: " & "),

                    TextSpan(
                      text: "Privacy Policy",
                      style: GoogleFonts.montserrat(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => print("Privacy clicked"),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              text: "Get OTP",
              onPressed: () async {
                final phone = phoneController.text.trim();

                if (phone.length != 10) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Enter valid mobile number")),
                  );
                  return;
                }

                final success = await AuthService.sendOtp(phone);

                if (success) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => OTPScreen(mobile: phone)),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Failed to send OTP")),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
