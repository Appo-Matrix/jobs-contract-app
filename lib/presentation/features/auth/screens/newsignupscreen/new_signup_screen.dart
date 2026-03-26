import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_contract_app/presentation/features/auth/screens/newsignupscreen/pageview/ConnectAccountsScreen.dart';
import 'package:job_contract_app/presentation/features/auth/screens/newsignupscreen/pageview/basic_details_screen.dart';
import 'package:job_contract_app/presentation/features/auth/screens/newsignupscreen/pageview/role_selection_screen.dart';
import 'package:job_contract_app/presentation/features/auth/screens/newsignupscreen/pageview/terms_conditionsS_screen.dart';
import 'package:job_contract_app/presentation/routes/routes.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';


import '../../../../../utils/common_widgets/StepProgressHeader.dart';
import '../../../../../utils/common_widgets/arqui_match_logo.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../routes/app_routes.dart';
import '../../../users/providers/register_provider.dart';

// Main Onboarding Flow Controller
class NewSignupScreen extends StatefulWidget {
  const NewSignupScreen({super.key});

  @override
  State<NewSignupScreen> createState() => _NewSignupScreenState();
}

class _NewSignupScreenState extends State<NewSignupScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final int _totalSteps = 4;

  // User data storage
  String? selectedRole;
  String? fullName;
  String? email;
  String? password;
  String? phoneNumber;
  double? latitude;
  double? longitude;
  bool? skipAccountConnection;

  Map<String, bool> agreements = {
    'terms': false,
    'privacy': false,
    'marketing': false,
  };

  late RegisterProvider _registerProvider;

  @override
  void initState() {
    super.initState();
    _registerProvider = context.read<RegisterProvider>();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _completeSignup() async {
    if (!_validateAllData()) return;

    context.loaderOverlay.show();

    try {
      _registerProvider.fullNameController.text = fullName ?? '';
      _registerProvider.emailController.text = email ?? '';
      _registerProvider.passwordController.text = password ?? '';
      _registerProvider.phoneNumberController.text = phoneNumber ?? '';
      _registerProvider.userTypeController.text = selectedRole ?? '';

      if (latitude != null && longitude != null) {
        _registerProvider.setLocation(latitude!, longitude!);
      }

      await _registerProvider.registerUser();

      if (!mounted) return;
      context.loaderOverlay.hide();

      // Show success dialog
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: JAppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check_circle_rounded,
                    color: JAppColors.primary, size: 60),
              ),
              const SizedBox(height: 16),
              Text(
                'Account Created!',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Your account has been created successfully. Please log in to continue.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: JAppColors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // close dialog
                    AppRouter.router.goNamed(Routes.loginScreen.name); // go to login
                  },
                  child: const Text(
                    'Go to Login',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      debugPrint('❌ Signup error: $e');
      if (mounted) context.loaderOverlay.hide();
      Fluttertoast.showToast(
        msg: 'Error: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  bool _validateAllData() {
    debugPrint('🔍 Validating all signup data:');

    if (selectedRole == null || selectedRole!.isEmpty) {
      _showError('Please select a role');
      return false;
    }

    if (fullName == null || fullName!.isEmpty) {
      _showError('Please enter full name');
      return false;
    }

    if (email == null || email!.isEmpty) {
      _showError('Please enter email');
      return false;
    }

    if (password == null || password!.isEmpty) {
      _showError('Please enter password');
      return false;
    }

    if (phoneNumber == null || phoneNumber!.isEmpty) {
      _showError('Please enter phone number');
      return false;
    }

    if (latitude == null || longitude == null) {
      _showError('Please select location');
      return false;
    }

    if (!agreements['terms']! || !agreements['privacy']!) {
      _showError('Please accept terms and privacy policy');
      return false;
    }

    debugPrint('✅ All data validated successfully!');
    return true;
  }

  void _showError(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _updateRole(String role) {
    setState(() => selectedRole = role);
    debugPrint('✅ Role selected: $role');
  }

  void _updateBasicDetails(Map<String, dynamic> details) {
    setState(() {
      fullName = details['fullName'] ?? '';
      email = details['email'] ?? '';
      password = details['password'] ?? '';
      phoneNumber = details['phone'] ?? details['phoneNumber'] ?? '';

      // Extract coordinates from location object
      if (details['location'] != null && details['location'] is Map) {
        final location = details['location'] as Map<String, dynamic>;
        final coordinates = location['coordinates'] as List<dynamic>?;
        if (coordinates != null && coordinates.length >= 2) {
          longitude = double.tryParse(coordinates[0].toString());
          latitude = double.tryParse(coordinates[1].toString());
        }
      }
    });

    debugPrint('✅ Basic Details Updated:');
    debugPrint('   fullName: $fullName');
    debugPrint('   email: $email');
    debugPrint('   phone: $phoneNumber');
    debugPrint('   coordinates: [$longitude, $latitude]');

    _nextStep();
  }

  void _handleAccountConnection(bool skip) {
    debugPrint('✅ Account Connection: Skip = $skip');
    setState(() => skipAccountConnection = skip);
    _nextStep();
  }

  void _updateAgreements(Map<String, bool> newAgreements) {
    setState(() => agreements = newAgreements);
    debugPrint('✅ Agreements Updated: $newAgreements');
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return 'selectRole'.tr();
      case 1:
        return 'basicDetails'.tr();
      case 2:
        return 'connectAccounts'.tr();
      case 3:
        return 'termsConditions'.tr();
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = JDeviceUtils.isDarkMode(context);

    return WillPopScope(
      onWillPop: () async {
        if (_currentStep > 0) {
          _previousStep();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Logo and Progress
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: Column(
                  children: [
                    ArquiMatchLogo(
                      logo: JImages.logoSVG,
                      logoHeight: 42.0,
                      logoWidth: 100.0,
                    ),
                    const SizedBox(height: 32),
                    StepProgressHeader(
                      currentStep: _currentStep,
                      totalSteps: _totalSteps,
                      stepTitle: _getStepTitle(),
                      isDark: isDark,
                    ),
                  ],
                ),
              ),

              // PageView for Steps
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() => _currentStep = index);
                  },
                  children: [
                    // Step 1: Role Selection
                    RoleSelectionScreen(
                      selectedRole: selectedRole,
                      onRoleSelected: _updateRole,
                      onContinue: _nextStep,
                    ),

                    // Step 2: Basic Details
                    BasicDetailsScreen(
                      selectedRole: selectedRole ?? 'contractor',
                      onContinue: _updateBasicDetails,
                      onBack: _previousStep,
                    ),

                    // Step 3: Connect Accounts
                    ConnectAccountsScreen(
                      onContinue: () =>
                          _handleAccountConnection(true), // Skip account connection
                      onBack: _previousStep,
                      onConnectAccount: () =>
                          _handleAccountConnection(false), // Connect account
                    ),

                    // Step 4: Terms & Conditions
                    TermsPrivacyScreen(
                      agreements: agreements,
                      onAgreementsChanged: _updateAgreements,
                      onComplete: _completeSignup,
                      onBack: _previousStep,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}