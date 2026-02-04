import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:totelxapp/widgets/primery_button.dart';
import 'home_screen.dart';
import '../widgets/primery_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final otpController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Image.asset("assets/otp.png", height: 120),
            const SizedBox(height: 20),
            Align(
              alignment: AlignmentGeometry.topLeft,
              child: Text(
                "OTP Verification",
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
            // TextField(
            //   controller: otpController,
            //   keyboardType: TextInputType.number,
            //   maxLength: 6,
            //   textAlign: TextAlign.center,
            //   decoration: InputDecoration(
            //     counterText: "",

            //     hint: Text(
            //       "",
            //       style: GoogleFonts.montserrat(color: Colors.grey),
            //     ),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),

            //     enabledBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10),
            //       borderSide: const BorderSide(color: Colors.grey, width: 1.2),
            //     ),

            //     focusedBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10),
            //       borderSide: const BorderSide(color: Colors.grey, width: 1.5),
            //     ),
            //   ),
            // ),
            PinCodeTextField(
              appContext: context,
              length: 6,
              keyboardType: TextInputType.number,
              animationType: AnimationType.fade,
              autoFocus: true,
              controller: otpController,

              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),

              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(10),
                fieldHeight: 50,
                fieldWidth: 45,
                activeColor: Colors.blue,
                selectedColor: Colors.blue,
                inactiveColor: Colors.grey,
              ),

              onChanged: (value) {},

              onCompleted: (value) {
                print("OTP entered: $value");
              },
            ),

            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                style: GoogleFonts.montserrat(
                  fontSize: 10,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  const TextSpan(text: "Don't get OTP? "),

                  TextSpan(
                    text: "Resend",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print("Resend clicked");

                        // 👉 call your resend OTP API here
                        // context.read<AuthCubit>().resendOtp();
                      },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            PrimaryButton(
              text: "Verify",
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
