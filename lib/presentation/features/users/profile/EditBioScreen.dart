// presentation/features/users/profile/edit_bio_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/main_button.dart';
import '../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../data/models/auth/login_res.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';

class EditBioScreen extends StatefulWidget {
  final String initialBio;
  const EditBioScreen({super.key, required this.initialBio});

  @override
  State<EditBioScreen> createState() => _EditBioScreenState();
}

class _EditBioScreenState extends State<EditBioScreen> {
  late final TextEditingController _bioCtrl;

  @override
  void initState() {
    super.initState();
    _bioCtrl = TextEditingController(text: widget.initialBio);
  }

  @override
  void dispose() {
    _bioCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    await context.read<AuthProvider>().updateProfile(
      UpdateProfileRequest(bio: _bioCtrl.text.trim()),
    );
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final isLoading = context.watch<UserProvider>().isLoading;

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      appBar: JAppbar(
        title: Text(
          'Edit Bio',
          style: AppTextStyle.dmSans(
            fontSize: JSizes.fontSizeLg,
            weight: FontWeight.bold,
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
          ),
        ),
        leadingIcon: const Icon(Icons.arrow_back),
        leadingOnPressed: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tell clients about yourself, your experience, and what makes you unique.',
                style: AppTextStyle.dmSans(
                  fontSize: 14,
                  weight: FontWeight.w400,
                  color: isDark
                      ? JAppColors.darkGray400
                      : JAppColors.lightGray500,
                ),
              ),
              const SizedBox(height: 16),
              TextFieldWidget(
                hintText: 'Write about yourself...',
                textEditingController: _bioCtrl,
                maxLines: 10,
              ),
              const Spacer(),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : MainButton(
                isDark: isDark,
                btn_title: 'Save',
                onTap: _save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}