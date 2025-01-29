import 'package:flutter/material.dart';
import 'package:job_contracts/utils/common_widgets/appbar.dart';
import 'package:job_contracts/utils/common_widgets/back_circle.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/colors.dart';

import '../../../../utils/constants/sizes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ForgetPasswordScreen(),
    );
  }
}

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(


      body: Padding(
        padding: const EdgeInsets.all(JSizes.defaultSpace),
        // Proper spacing
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.only(top: JSizes.defaultSpace),
              child: BackCircle(),
            ),
            const SizedBox(height: 24), // Space after back button

            // Title
             Text(
              "Forget Password",

              style:  AppTextStyle.domaineArrow(color: Colors.black, fontSize: 24.0, weight: FontWeight.w600),

            ),
            const SizedBox(height: 8),

            // Subtitle
            const Text(
              "Don't worry! It happens. Please enter the email associated with your account.",
              style: TextStyle(
                fontSize: 16,
                color:  Colors.grey,
              ),
            ),
            const SizedBox(height: 32),

            // Email Input Field
            Form(
              key: formKey,
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  filled: true,
                  fillColor: Colors.grey[200],
                  // Light grey background
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  } else if (!RegExp(
                          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                      .hasMatch(value)) {
                    return "Enter a valid email address";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 24),

            // Send Code Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Password reset link sent!"),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: JAppColors.primary, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Send Code",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Login Text
            Center(
              child: RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to login page
                        },
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
