import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../data/models/job_applications/job_application_submit_request.dart';
import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../NavigationMenu.dart';
import '../../providers/application_provider.dart'; // ✅ correct provider

class JobDetailsPage extends StatefulWidget {
  final String? jobId;

  const JobDetailsPage({
    super.key,
    this.jobId,
  });

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  final TextEditingController _coverLetterController = TextEditingController();

  @override
  void dispose() {
    _coverLetterController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit(BuildContext context) async {
    final provider = context.read<ApplicationProvider>();

    if (_coverLetterController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please write a cover letter before submitting.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // ✅ Use submitApplication with JobApplicationSubmitRequest
    await provider.submitApplication(
      JobApplicationSubmitRequest(
        jobId: widget.jobId ?? '',
        coverLetter: _coverLetterController.text.trim(),
      ),
    );

    if (!mounted) return;

    // ✅ Check provider.error (not errorMessage)
    if (provider.error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Application submitted successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const NavigationMenu()),
            (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.error ?? 'Something went wrong'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final double height = JDeviceUtils.getScreenHeight(context);

    // ✅ Use Consumer with registered ApplicationProvider (no ChangeNotifierProvider wrapper)
    return Consumer<ApplicationProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: JAppbar(
            leadingIcon: const Icon(Icons.arrow_back),
            leadingOnPressed: () => Navigator.pop(context),
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'coverLetterTitle',
                            style: AppTextStyle.onest(
                              color: isDark
                                  ? JAppColors.darkGray100
                                  : JAppColors.lightGray900,
                              fontSize: 14.0,
                              weight: FontWeight.w500,
                            ),
                          ).tr(),
                          const SizedBox(height: 8),
                          Container(
                            height: height * 0.7,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(8),
                              color: isDark
                                  ? JAppColors.backGroundDarkCard
                                  .withValues(alpha: 0.4)
                                  : Colors.transparent,
                            ),
                            child: TextField(
                              controller: _coverLetterController,
                              maxLines: null,
                              expands: true,
                              textAlignVertical: TextAlignVertical.top,
                              style: AppTextStyle.dmSans(
                                color: isDark
                                    ? JAppColors.lightGray100
                                    : JAppColors.lightGray800,
                                fontSize: 14.9,
                                weight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                hintText: 'describeFitForRole'.tr(),
                                hintStyle: TextStyle(
                                  color: isDark
                                      ? Colors.grey[500]
                                      : Colors.grey[400],
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                contentPadding: const EdgeInsets.all(16),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),

                  // ── Bottom Buttons ─────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: MainButton(
                            onTap: provider.isLoading
                                ? null
                                : () => Navigator.pop(context),
                            btn_title: 'Cancel',
                            btn_radius: 6,
                            buttonType: MainButtonType.outlined,
                            btn_border_color: isDark
                                ? JAppColors.lightGray100
                                : JAppColors.primary,
                            title_color: isDark
                                ? JAppColors.lightGray100
                                : JAppColors.primary,
                            text_fontweight: FontWeight.w600,
                            image_value: false,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: MainButton(
                            onTap: provider.isLoading
                                ? null
                                : () => _handleSubmit(context),
                            btn_title: provider.isLoading
                                ? 'Submitting...'
                                : 'Submit',
                            btn_radius: 6,
                            btn_color: JAppColors.main,
                            btn_border_color: const Color(0xff7030F1),
                            title_color: Colors.white,
                            text_fontweight: FontWeight.w600,
                            image_value: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // ── Loading overlay ────────────────────────────────────────────
              if (provider.isLoading)
                Container(
                  color: Colors.black.withValues(alpha: 0.4),
                  child: const Center(
                    child: CircularProgressIndicator(color: JAppColors.main),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}