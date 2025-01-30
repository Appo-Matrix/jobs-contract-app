import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      // Uses system theme
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFF6B46C1),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black54),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: const Color(0xFF6B46C1),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      ),
      home: const ResetPasswordScreen(),
    );
  }
}

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                // Added border instead of background color
                color: isDarkMode ? Colors.white12 : Colors.black12,
                width: 1.5,
              ),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new,
                  size: 16, color: theme.textTheme.bodyLarge!.color),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///-- Title
            Text(
              "Reset Password",
              style: theme.textTheme.bodyLarge!.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
///-- SubTitle
            Text(
              "Please type something you’ll remember",
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: JAppColors.darkGray500,
              ),
            ),
            const SizedBox(height: 30),
///-- Password from
            Form(
              key: formKey,
              child: Column(
                children: [
        /// new password field
                  TextFormField(
                    controller: newPasswordController,
                    obscureText: true,
                    style: TextStyle(color: theme.textTheme.bodyLarge!.color),
                    decoration: InputDecoration(
                      hintText: "Enter New Password",
                      hintStyle: TextStyle(
                          color: isDarkMode
                              ? JAppColors.darkGray500
                              :  JAppColors.darkGray500),
                      filled: true,
                      fillColor: isDarkMode ? Colors.transparent : Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter a new password";
                      } else if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  ///-- Confirm Password Field
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    style: TextStyle(color: theme.textTheme.bodyLarge!.color),
                    decoration: InputDecoration(
                      hintText: "Repeat New Password",
                      hintStyle: TextStyle(
                          color: isDarkMode
                              ? JAppColors.darkGray500
                              :  JAppColors.darkGray500),
                      filled: true,
                      fillColor: isDarkMode ? Colors.transparent : Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: isDarkMode
                                ? Colors.white30
                                : JAppColors.darkGray800),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Confirm your password";
                      } else if (value != newPasswordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                  ),

                ],
              ),
            ),
            Spacer(),

            ///-- Reset Password Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Password reset successfully!"),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: JAppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Reset Password",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: JAppColors.darkGray100,
                  ),
                ),
              ),
            ),
            SizedBox()
          ],
        ),
      ),
    );
  }
}
