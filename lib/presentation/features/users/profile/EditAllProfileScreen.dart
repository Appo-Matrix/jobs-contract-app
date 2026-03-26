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

class EditAllProfileScreen extends StatefulWidget {
  final User user;
  const EditAllProfileScreen({super.key, required this.user});

  @override
  State<EditAllProfileScreen> createState() => _EditAllProfileScreenState();
}

class _EditAllProfileScreenState extends State<EditAllProfileScreen> {
  late final TextEditingController nameCtrl;
  late final TextEditingController bioCtrl;
  late final TextEditingController titleCtrl;
  late final TextEditingController phoneCtrl;
  late final TextEditingController emailCtrl;
  late final TextEditingController countryCtrl;
  late final TextEditingController cityCtrl;
  late final TextEditingController stateCtrl;
  late final TextEditingController streetCtrl;
  late final TextEditingController areaCtrl;
  late final TextEditingController postalCtrl;
  late final TextEditingController rangeCtrl;
  late final TextEditingController serviceCtrl;
  late final TextEditingController specialtyCtrl;
  late final TextEditingController expCtrl;

  @override
  void initState() {
    super.initState();
    final u = widget.user;
    nameCtrl      = TextEditingController(text: u.fullName);
    bioCtrl       = TextEditingController(text: u.bio);
    titleCtrl     = TextEditingController(text: u.title);
    phoneCtrl     = TextEditingController(text: u.phoneNumber);
    emailCtrl     = TextEditingController(text: u.email);
    countryCtrl   = TextEditingController(text: u.country);
    cityCtrl      = TextEditingController(text: u.city);
    stateCtrl     = TextEditingController(text: u.stateOrProvince);
    streetCtrl    = TextEditingController(text: u.streetAndNumber);
    areaCtrl      = TextEditingController(text: u.neighbourhoodArea);
    postalCtrl    = TextEditingController(text: u.postalCode);
    rangeCtrl     = TextEditingController(text: u.serviceRange);
    serviceCtrl   = TextEditingController(text: u.serviceType);
    specialtyCtrl = TextEditingController(text: u.specialty);
    expCtrl       = TextEditingController(
      text: u.yearsOfExperience > 0 ? '${u.yearsOfExperience}' : '',
    );
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    bioCtrl.dispose();
    titleCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    countryCtrl.dispose();
    cityCtrl.dispose();
    stateCtrl.dispose();
    streetCtrl.dispose();
    areaCtrl.dispose();
    postalCtrl.dispose();
    rangeCtrl.dispose();
    serviceCtrl.dispose();
    specialtyCtrl.dispose();
    expCtrl.dispose();
    super.dispose();
  }

  String? _v(TextEditingController c) {
    final t = c.text.trim();
    return t.isNotEmpty ? t : null;
  }

  Future<void> _save() async {
    final exp = int.tryParse(expCtrl.text.trim()) ?? 0;
    await context.read<AuthProvider>().updateProfile(
      UpdateProfileRequest(
        fullName:          _v(nameCtrl),
        bio:               _v(bioCtrl),
        title:             _v(titleCtrl),
        phoneNumber:       _v(phoneCtrl),
        email:             _v(emailCtrl),
        country:           _v(countryCtrl),
        city:              _v(cityCtrl),
        stateOrProvince:   _v(stateCtrl),
        streetAndNumber:   _v(streetCtrl),
        neighbourhoodArea: _v(areaCtrl),
        postalCode:        _v(postalCtrl),
        serviceRange:      _v(rangeCtrl),
        serviceType:       _v(serviceCtrl),
        specialty:         _v(specialtyCtrl),
        yearsOfExperience: exp,
      ),
    );
    if (mounted) Navigator.pop(context);
  }

  // ── Section header ────────────────────────────────────────────────────────
  Widget _groupHeader(String label, bool isDark) => Padding(
    padding: const EdgeInsets.only(top: 24, bottom: 8),
    child: Row(
      children: [
        Text(
          label.toUpperCase(),
          style: AppTextStyle.dmSans(
            fontSize: 11,
            weight: FontWeight.w700,
            color: JAppColors.primary,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Divider(
            color: isDark ? JAppColors.darkGray600 : JAppColors.lightGray300,
            height: 1,
          ),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    final isDark    = JDeviceUtils.isDarkMode(context);
    final isLoading = context.watch<UserProvider>().isLoading;

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      appBar: JAppbar(
        title: Text(
          'Edit Profile',
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
        child: Column(
          children: [
            // ── Scrollable fields ──────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ── Basic Info ─────────────────────────────────────────
                    _groupHeader('Basic Info', isDark),
                    TextFieldWidget(
                      hintText: 'Your full name',
                      textEditingController: nameCtrl,
                    ),
                    const SizedBox(height: 12),
                    TextFieldWidget(
                      hintText: 'e.g. Professional Plumber',
                      textEditingController: titleCtrl,
                    ),
                    const SizedBox(height: 12),
                    TextFieldWidget(
                      hintText: 'Write about yourself...',
                      textEditingController: bioCtrl,
                      maxLines: 4,
                    ),

                    // ── Contact ────────────────────────────────────────────
                    _groupHeader('Contact', isDark),
                    TextFieldWidget(
                      hintText: '+923001234567',
                      textEditingController: phoneCtrl,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 12),
                    TextFieldWidget(
                      hintText: 'you@email.com',
                      textEditingController: emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      isEmail: true,
                    ),

                    // ── Location ───────────────────────────────────────────
                    _groupHeader('Location', isDark),
                    TextFieldWidget(
                      hintText: 'e.g. Pakistan',
                      textEditingController: countryCtrl,
                    ),
                    const SizedBox(height: 12),
                    TextFieldWidget(
                      hintText: 'e.g. Azad Kashmir',
                      textEditingController: stateCtrl,
                    ),
                    const SizedBox(height: 12),
                    TextFieldWidget(
                      hintText: 'e.g. Bagh',
                      textEditingController: cityCtrl,
                    ),
                    const SizedBox(height: 12),
                    TextFieldWidget(
                      hintText: 'e.g. Street 123',
                      textEditingController: streetCtrl,
                    ),
                    const SizedBox(height: 12),
                    TextFieldWidget(
                      hintText: 'e.g. Main Bazar',
                      textEditingController: areaCtrl,
                    ),
                    const SizedBox(height: 12),
                    TextFieldWidget(
                      hintText: 'e.g. 12345',
                      textEditingController: postalCtrl,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    TextFieldWidget(
                      hintText: 'e.g. city/state',
                      textEditingController: rangeCtrl,
                    ),

                    // ── Professional ───────────────────────────────────────
                    _groupHeader('Professional', isDark),
                    TextFieldWidget(
                      hintText: 'e.g. Plumber, Electrician',
                      textEditingController: serviceCtrl,
                    ),
                    const SizedBox(height: 12),
                    TextFieldWidget(
                      hintText: 'e.g. Pipe fixing',
                      textEditingController: specialtyCtrl,
                    ),
                    const SizedBox(height: 12),
                    TextFieldWidget(
                      hintText: 'Years of experience e.g. 3',
                      textEditingController: expCtrl,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // ── Pinned Save button ─────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : MainButton(
                isDark: isDark,
                btn_title: 'Save All Changes',
                onTap: _save,
              ),
            ),
          ],
        ),
      ),
    );
  }
}