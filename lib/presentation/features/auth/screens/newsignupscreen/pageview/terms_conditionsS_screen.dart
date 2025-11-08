import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../../utils/common_widgets/main_button.dart';
import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/device/device_utility.dart';


class TermsPrivacyScreen extends StatefulWidget {
  final Map<String, bool> agreements;
  final Function(Map<String, bool>) onAgreementsChanged;
  final VoidCallback onComplete;
  final VoidCallback onBack;

  const TermsPrivacyScreen({
    super.key,
    required this.agreements,
    required this.onAgreementsChanged,
    required this.onComplete,
    required this.onBack,
  });

  @override
  State<TermsPrivacyScreen> createState() => _TermsPrivacyScreenState();
}

class _TermsPrivacyScreenState extends State<TermsPrivacyScreen> {
  late bool _agreeToTerms;
  late bool _agreeToPrivacy;
  late bool _agreeToMarketing;

  @override
  void initState() {
    super.initState();
    _agreeToTerms = widget.agreements['terms'] ?? false;
    _agreeToPrivacy = widget.agreements['privacy'] ?? false;
    _agreeToMarketing = widget.agreements['marketing'] ?? false;
  }

  void _updateAgreements() {
    widget.onAgreementsChanged({
      'terms': _agreeToTerms,
      'privacy': _agreeToPrivacy,
      'marketing': _agreeToMarketing,
    });
  }

  void _handleComplete() {
    if (_agreeToTerms && _agreeToPrivacy) {
      _updateAgreements();
      widget.onComplete();
    }
  }

  void _showTermsDialog(String title, String content) {
    final bool isDark = JDeviceUtils.isDarkMode(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? JAppColors.darkBackground : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          title,
          style: AppTextStyle.dmSans(
            fontSize: 20.0,
            weight: FontWeight.w700,
            color: isDark
                ? JAppColors.lightGray100
                : JAppColors.darkGray900,
          ),
        ),
        content: SingleChildScrollView(
          child: Text(
            content,
            style: AppTextStyle.dmSans(
              fontSize: 14.0,
              height: 1.6,
              weight: FontWeight.w400,
              color: isDark
                  ? JAppColors.darkGray100
                  : JAppColors.darkGray700,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'close'.tr(),
              style: AppTextStyle.dmSans(
                fontSize: 15.0,
                color: JAppColors.primary,
                weight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = JDeviceUtils.isDarkMode(context);
    final canComplete = _agreeToTerms && _agreeToPrivacy;

    return Scaffold(
      backgroundColor: isDark ? JAppColors.darkBackground : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'termsAndPrivacy',
                style: AppTextStyle.dmSans(
                  fontSize: 26.0,
                  weight: FontWeight.w700,
                  color: isDark
                      ? JAppColors.lightGray100
                      : JAppColors.darkGray900,
                ),
              ).tr(),
              const SizedBox(height: 8),
              Text(
                'termsAndPrivacySubtitle',
                style: AppTextStyle.dmSans(
                  fontSize: 15.0,
                  color: isDark
                      ? JAppColors.darkGray100
                      : JAppColors.darkGray500,
                  weight: FontWeight.w400,
                  height: 1.5,
                ),
              ).tr(),

              const SizedBox(height: 32),

              // Terms of Service Section
              _AgreementSection(
                value: _agreeToTerms,
                onChanged: (val) {
                  setState(() => _agreeToTerms = val!);
                  _updateAgreements();
                },
                title: 'agreeToTerms',
                subtitle: 'termsSubtitle',
                linkText: 'readTerms',
                onLinkTap: () => _showTermsDialog(
                  'termsOfService'.tr(),
                  'termsContent'.tr(),
                ),
                isDark: isDark,
                isRequired: true,
              ),

              const SizedBox(height: 20),

              // Privacy Policy Section
              _AgreementSection(
                value: _agreeToPrivacy,
                onChanged: (val) {
                  setState(() => _agreeToPrivacy = val!);
                  _updateAgreements();
                },
                title: 'agreeToPrivacy',
                subtitle: 'privacySubtitle',
                linkText: 'readPrivacy',
                onLinkTap: () => _showTermsDialog(
                  'privacyPolicy'.tr(),
                  'privacyContent'.tr(),
                ),
                isDark: isDark,
                isRequired: true,
              ),

              const SizedBox(height: 20),

              // Marketing Emails Section
              _AgreementSection(
                value: _agreeToMarketing,
                onChanged: (val) {
                  setState(() => _agreeToMarketing = val!);
                  _updateAgreements();
                },
                title: 'agreeToMarketing',
                subtitle: 'marketingSubtitle',
                isDark: isDark,
                isRequired: false,
              ),

              const SizedBox(height: 32),

              // Validation Message
              if (!canComplete)
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.orange.withOpacity(0.1)
                        : Colors.orange[50],
                    border: Border.all(
                      color: isDark
                          ? Colors.orange.withOpacity(0.3)
                          : Colors.orange[200]!,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.orange[700],
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'acceptRequiredAgreements'.tr(),
                          style: AppTextStyle.dmSans(
                            fontSize: 13.0,
                            color: JAppColors.error900,
                            weight: FontWeight.w500,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // Complete Button
              MainButton(
                onTap: canComplete ? _handleComplete : null,
                btn_color: canComplete
                    ? JAppColors.primary
                    : (isDark
                    ? JAppColors.darkGray300
                    : JAppColors.darkGray200),
                btn_title: 'completeSignup',
                btn_radius: 12,

                title_color: Colors.white,
                text_fontweight: FontWeight.w600,
                image_value: false,
                isDark: isDark,
              ),

              const SizedBox(height: 16),

              // Back Button
              Center(
                child: TextButton.icon(
                  onPressed: widget.onBack,
                  icon: const Icon(
                    Icons.arrow_back,
                    color: JAppColors.primary,
                    size: 20,
                  ),
                  label: Text(
                    'back'.tr(),
                    style: AppTextStyle.dmSans(
                      fontSize: 15.0,
                      color: JAppColors.primary,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// Agreement Section Widget
class _AgreementSection extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final String title;
  final String subtitle;
  final String? linkText;
  final VoidCallback? onLinkTap;
  final bool isDark;
  final bool isRequired;

  const _AgreementSection({
    required this.value,
    required this.onChanged,
    required this.title,
    required this.subtitle,
    this.linkText,
    this.onLinkTap,
    required this.isDark,
    required this.isRequired,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? JAppColors.darkGray300.withOpacity(0.2)
            : Colors.grey[50],
        border: Border.all(
          color: value
              ? JAppColors.primary
              : (isDark ? JAppColors.darkGray300 : Colors.grey[300]!),
          width: value ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom Checkbox
              GestureDetector(
                onTap: () => onChanged?.call(!value),
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: value ? JAppColors.primary : Colors.transparent,
                    border: Border.all(
                      color: value
                          ? JAppColors.primary
                          : (isDark
                          ? JAppColors.darkGray300
                          : Colors.grey[400]!),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: value
                      ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  )
                      : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title.tr(),
                            style: AppTextStyle.dmSans(
                              fontSize: 15.0,
                              weight: FontWeight.w600,
                              color: isDark
                                  ? JAppColors.lightGray100
                                  : JAppColors.darkGray900,
                            ),
                          ),
                        ),
                        if (isRequired)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: JAppColors.error600.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'required'.tr(),
                              style: AppTextStyle.dmSans(
                                fontSize: 10.0,
                                color: JAppColors.error600,
                                weight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle.tr(),
                      style: AppTextStyle.dmSans(
                        fontSize: 13.0,
                        color: isDark
                            ? JAppColors.darkGray100
                            : JAppColors.darkGray500,
                        weight: FontWeight.w400,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (linkText != null && onLinkTap != null) ...[
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 36),
              child: GestureDetector(
                onTap: onLinkTap,
                child: Row(
                  children: [
                    Text(
                      linkText!.tr(),
                      style: AppTextStyle.dmSans(
                        fontSize: 13.0,
                        color: JAppColors.primary,
                        weight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_forward,
                      size: 14,
                      color: JAppColors.primary,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}