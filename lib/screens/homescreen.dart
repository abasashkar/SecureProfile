import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:secureprofile/screens/otp_screen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final _controller = TextEditingController();
  bool _validate = false;

  String vId = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xfffafafc),
        body: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: 100.0, horizontal: 18.0),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Continue with phone",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    "We will send one time password ",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text(
                    "on this phone number ",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.0),
                    child: Image(
                      image: AssetImage(
                        'assets/Screenshot 2024-04-13 at 6.25.35 PM.png',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  const Text(
                    'Enter your phone number',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: _controller,
                    decoration: InputDecoration(
                      errorText: _validate ? "Value Can't Be Empty" : null,
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: '+91 ${_controller.text.trim()}',
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException e) {},
                    codeSent: (String verificationId, int? resendToken) {
                      setState(() {
                        vId = verificationId;
                      });
                      if (context.mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtpScreen(
                                mobileNo: _controller.text.trim(),
                                verificationId: vId),
                          ),
                        );
                      }
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                  );
                  setState(() {
                    _validate = _controller.text.isEmpty;
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 90, vertical: 13),
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Send OTP',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
