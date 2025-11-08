import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/common_widgets/main_button.dart';
import '../../../../../../utils/common_widgets/role_card.dart';
import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/device/device_utility.dart';


class RoleSelectionScreen extends StatefulWidget {
  final String? selectedRole;
  final Function(String) onRoleSelected;
  final VoidCallback onContinue;

  const RoleSelectionScreen({
    super.key,
    required this.selectedRole,
    required this.onRoleSelected,
    required this.onContinue,
  });

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? _localSelectedRole;

  @override
  void initState() {
    super.initState();
    _localSelectedRole = widget.selectedRole;
  }

  void _handleRoleSelection(String role) {
    setState(() => _localSelectedRole = role);
    widget.onRoleSelected(role);
  }

  void _handleContinue() {
    if (_localSelectedRole != null) widget.onContinue();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.darkBackground : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Text(
                'selectYourRole'.tr(),
                style: AppTextStyle.dmSans(
                  fontSize: 26.0,
                  weight: FontWeight.w700,
                  color: isDark
                      ? JAppColors.lightGray100
                      : JAppColors.darkGray900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'selectRoleSubtitle'.tr(),
                style: AppTextStyle.dmSans(
                  fontSize: 15.0,
                  color: isDark
                      ? JAppColors.darkGray100
                      : JAppColors.darkGray500,
                  weight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 40),

              /// --- Role Cards ---
              RoleCard(
                icon: Icons.person_outline,
                title: 'contractor'.tr(),
                subtitle: 'contractorDesc'.tr(),
                isSelected: _localSelectedRole == 'contractor',
                onTap: () => _handleRoleSelection('contractor'),
                isDark: isDark,
              ),
              const SizedBox(height: 16),
              // RoleCard(
              //   icon: Icons.work_outline,
              //   title: 'client'.tr(),
              //   subtitle: 'clientDesc'.tr(),
              //   isSelected: _localSelectedRole == 'client',
              //   onTap: () => _handleRoleSelection('client'),
              //   isDark: isDark,
              // ),
              // const SizedBox(height: 16),
              RoleCard(
                icon: Icons.business_outlined,
                title: 'company'.tr(),
                subtitle: 'companyDesc'.tr(),
                isSelected: _localSelectedRole == 'company',
                onTap: () => _handleRoleSelection('company'),
                isDark: isDark,
              ),

              const Spacer(),

              /// --- Continue Button ---
              MainButton(
                onTap: _localSelectedRole != null ? _handleContinue : null,
                btn_color: _localSelectedRole != null
                    ? JAppColors.primary
                    : (isDark
                    ? JAppColors.darkGray300
                    : JAppColors.darkGray200),
                btn_title: 'continue',
                btn_radius: 12,

                title_color: Colors.white,
                text_fontweight: FontWeight.w600,
                image_value: false,
                isDark: isDark,
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
