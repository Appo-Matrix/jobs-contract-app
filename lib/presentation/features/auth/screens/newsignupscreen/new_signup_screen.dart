import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:job_contracts/presentation/features/auth/screens/newsignupscreen/pageview/ConnectAccountsScreen.dart';
import 'package:job_contracts/presentation/features/auth/screens/newsignupscreen/pageview/basic_details_screen.dart';
import 'package:job_contracts/presentation/features/auth/screens/newsignupscreen/pageview/role_selection_screen.dart';
import 'package:job_contracts/presentation/features/auth/screens/newsignupscreen/pageview/terms_conditionsS_screen.dart';
import 'package:job_contracts/utils/constants/image_string.dart';

import '../../../../../utils/common_widgets/StepProgressHeader.dart';
import '../../../../../utils/common_widgets/arqui_match_logo.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/device/device_utility.dart';

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
  Map<String, String> basicDetails = {};
  Map<String, bool> agreements = {
    'terms': false,
    'privacy': false,
    'marketing': false,
  };
  Map<String, String> finalDetails = {};

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
    } else {
      _completeSignup();
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

  void _completeSignup() {
    debugPrint('✅ Signup completed!');
    debugPrint('Role: $selectedRole');
    debugPrint('Basic Details: $basicDetails');
    debugPrint('Agreements: $agreements');
    debugPrint('Final Details: $finalDetails');

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('accountCreatedSuccess'.tr()),
        backgroundColor: JAppColors.primary,
        duration: const Duration(seconds: 3),
      ),
    );

    // Navigate to home or next screen
    // AppRouter.router.push('/navigationMenu');
  }

  void _updateRole(String role) {
    setState(() => selectedRole = role);
  }

  void _updateBasicDetails(Map<String, String> details) {
    setState(() => basicDetails = details);
  }

  void _updateAgreements(Map<String, bool> newAgreements) {
    setState(() => agreements = newAgreements);
  }

  void _updateFinalDetails(Map<String, String> details) {
    setState(() => finalDetails = details);
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

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Logo and Progress
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Column(
                children: [


                  ArquiMatchLogo(
                    logo:  JImages.logoSVG,      // Pass the logo here
                    logoHeight: 42.0,    // Optional: override default height
                    logoWidth: 100.0,    // Optional: override default width
                  ),
                  const SizedBox(height: 32),

                  // Progress Header
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
                    onContinue: (data) {
                      _updateBasicDetails(data);
                      _nextStep();
                    },
                    onBack: _previousStep,
                  ),

                  // Step 3: Connect Accounts
                  ConnectAccountsScreen(
                    onContinue: _nextStep,
                    onBack: _previousStep,
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
    );
  }
}
