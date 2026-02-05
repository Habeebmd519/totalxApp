import 'package:flutter/material.dart';
import 'package:msg91/msg91.dart';
import 'package:sendotp_flutter_sdk/sendotp_flutter_sdk.dart';

class OTPWidgetScreen extends StatefulWidget {
  @override
  _OTPWidgetScreenState createState() => _OTPWidgetScreenState();
}

class _OTPWidgetScreenState extends State<OTPWidgetScreen> {
  final String widgetId = 'YOUR_WIDGET_ID'; // From MSG91 dashboard
  final String authToken = 'YOUR_AUTH_TOKEN'; // From MSG91 dashboard

  String phoneNumber = '';
  String requestId = '';
  String otp = '';

  @override
  void initState() {
    super.initState();
    OTPWidget.initializeWidget(widgetId, authToken);
  }

  // Send OTP
  Future<void> sendOtp() async {
    if (phoneNumber.length < 10) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Enter a valid phone number")));
      return;
    }

    final data = {
      'identifier': '91$phoneNumber', // Include country code
      'flowId': 'YOUR_TEMPLATE_ID', // Your approved template ID
    };

    try {
      final response = await OTPWidget.sendOTP(data);
      print('Send OTP Response: $response');

      requestId = response?['request_id'] ?? '';

      if (requestId.isNotEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('OTP sent successfully!')));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to send OTP!')));
      }
    } catch (e) {
      print('Error sending OTP: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error sending OTP')));
    }
  }

  // Verify OTP
  Future<void> verifyOtp() async {
    final data = {'reqId': requestId, 'otp': otp};

    try {
      final response = await OTPWidget.verifyOTP(data);
      print('Verify OTP Response: $response');

      if (response?['type'] == 'success') {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('OTP verified successfully!')));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('OTP verification failed!')));
      }
    } catch (e) {
      print('Error verifying OTP: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error verifying OTP')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MSG91 OTP Widget')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Enter Phone Number'),
              keyboardType: TextInputType.phone,
              onChanged: (value) => phoneNumber = value,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: sendOtp, child: Text('Send OTP')),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: 'Enter OTP'),
              keyboardType: TextInputType.number,
              onChanged: (value) => otp = value,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: verifyOtp, child: Text('Verify OTP')),
          ],
        ),
      ),
    );
  }
}
