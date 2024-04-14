import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:secureprofile/controller/user_controller.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    super.key,
    required this.mobileNo,
    required this.verificationId,
  });

  final String mobileNo;
  final String verificationId;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());

  FirebaseAuth auth = FirebaseAuth.instance;
  UserController userController = UserController();

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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Verify mobile Number",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
              const SizedBox(height: 4),
              const Text(
                "We sent a verification code to",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
              const SizedBox(height: 3),
              Text(
                "${widget.mobileNo} enter this number",
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
              const SizedBox(height: 35),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: Image(
                  image: AssetImage(
                      'assets/Screenshot 2024-04-13 at 7.58.41 PM.png'),
                ),
              ),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  6,
                  (index) => SizedBox(
                    width: 36,
                    height: 39,
                    child: TextField(
                      controller: _controllers[index],
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        if (value.length == 1 && index < 5) {
                          FocusScope.of(context).nextFocus();
                        } else if (value.isEmpty && index > 0) {
                          FocusScope.of(context).previousFocus();
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String smsCode =
                      _controllers.map((controller) => controller.text).join();
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId, smsCode: smsCode);

                  print("VID: ${widget.verificationId}");
                  print("Sms: ${smsCode}");

                  // Sign the user in (or link) with the credential
                  await auth.signInWithCredential(credential);

                  if (context.mounted) {
                    userController.checkUser(widget.mobileNo, context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 90, vertical: 13),
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Verify and proceed',
                ),
              ),
              const SizedBox(height: 20),
              const Text("Don't receive code? Resend code"),
            ],
          ),
        ),
      ),
    );
  }
}
