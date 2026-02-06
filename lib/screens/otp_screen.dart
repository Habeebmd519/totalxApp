import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totelxapp/blocs/timer_cubit/timer_cubit.dart';
import 'package:totelxapp/blocs/timer_cubit/timer_state.dart';
import 'package:totelxapp/services/msg91_service.dart';
// import 'package:totelxapp/widgets/primery_button.dart';
import 'home_screen.dart';
import '../widgets/primery_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatelessWidget {
  final String mobile;
  OTPScreen({super.key, required this.mobile});

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
            Text(
              "Enter the verification code we just sent to your number +91 *******${mobile.substring(mobile.length - 2)}.",
            ),
            SizedBox(height: 15),
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
            BlocBuilder<TimerBloc, TimerState>(
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 1. Red Timer (Shows only when running)
                    if (state.isRunning && state.seconds > 0)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          "${state.seconds} Sec",
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: const Color(
                              0xFFF4511E,
                            ), // Reddish-Coral color
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                    // 2. Resend Section
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          const TextSpan(text: "Don't Get OTP? "),
                          TextSpan(
                            text: "Resend",
                            style: TextStyle(
                              color: state.isRunning
                                  ? Colors.grey
                                  : Colors.blue,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = state.isRunning
                                  ? null
                                  : () {
                                      // Restart the timer via Bloc
                                      context.read<TimerBloc>().startTimer();
                                      // Trigger your API call here
                                    },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 20),
            PrimaryButton(
              text: "Verify",
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => HomeScreen()),
                );
                final otp = otpController.text.trim();

                if (otp.length == 6) {
                  bool ok = await Msg91Service.verifyOtp(mobile, otp);

                  if (ok) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Invalid OTP!")),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Enter 6 digit OTP")),
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


//  /// VERIFY OTP
//   static Future<bool> verifyOtp(String mobile, String otp) async {
//     try {
//       final formattedMobile = "91$mobile";

//       final res = await _msg91.getOtp().verify(
//         otp: otp,
//         mobileNumber: formattedMobile,
//       );

//       print("VERIFY RESPONSE: $res");

//       // The package returns an object with type "success" if OTP is correct
//       return res.type == "success";
//     } catch (e, s) {
//       print("VERIFY ERROR: $e");
//       print(s);
//       return false;
//     }
//   }