import 'package:flutter/material.dart';
// import 'package:totelxapp/widgets/primery_button.dart';
import 'otp_screen.dart';
// import '../widgets/primary_button.dart';
import '../widgets/primery_button.dart';

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
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: "Enter Phone Number",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              text: "Get OTP",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const OTPScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
