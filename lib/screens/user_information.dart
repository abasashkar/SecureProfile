import 'package:flutter/material.dart';
import 'package:secureprofile/controller/user_controller.dart';
import 'package:secureprofile/model/user_model.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key, required this.uid, required this.phone});

  final String? uid;
  final String phone;
  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  UserModel? user;
  UserController userController = UserController();

  void getUser() async {
    user = await userController.getUser(widget.uid!);
    setState(() {
      nameTextController.text = user!.name;
      emailTextController.text = user!.email;
      addressController.text = user!.address;
    });
  }

  @override
  void initState() {
    phoneTextController.text = widget.phone;
    if (widget.uid != null) {
      getUser();
    }
    super.initState();
  }

  // TextEditing Controllers
  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController addressController = TextEditingController();

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Your Information",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              buildTextField(
                hintText: "Your name",
                controller: nameTextController,
                isDisabled: widget.uid != null,
              ),
              const SizedBox(
                height: 15,
              ),
              buildTextField(
                hintText: "Email",
                controller: emailTextController,
                isDisabled: widget.uid != null,
              ),
              const SizedBox(
                height: 15,
              ),
              buildTextField(
                hintText: "Phone",
                controller: phoneTextController,
                isDisabled: true,
              ),
              const SizedBox(
                height: 15,
              ),
              buildTextField(
                hintText: "Address",
                controller: addressController,
                isDisabled: widget.uid != null,
              ),
              const SizedBox(
                height: 15,
              ),
              if (widget.uid == null)
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      await userController.addUser(
                        name: nameTextController.text.trim(),
                        phone: widget.phone,
                        email: emailTextController.text.trim(),
                        address: addressController.text.trim(),
                        context: context,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 90, vertical: 13),
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'Save Information',
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      {required TextEditingController controller,
      required String hintText,
      bool isDisabled = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          controller: controller,
          enabled: !isDisabled,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}
