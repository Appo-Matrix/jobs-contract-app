import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/device/device_utility.dart';
import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/back_circle.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../routes/app_routes.dart';

class DeliverContractScreen extends StatefulWidget {
  const DeliverContractScreen({super.key});

  @override
  State<DeliverContractScreen> createState() => _DeliverContractScreenState();
}

class _DeliverContractScreenState extends State<DeliverContractScreen> {
  final TextEditingController _messageController = TextEditingController();
  String? attachmentPath;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  // Mock function for handling file upload
  void _handleFileUpload() {
    // This would be replaced with actual file picker implementation
    setState(() {
      attachmentPath = 'file_selected.png'; // Mock path
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      appBar: JAppbar(

        title: Text(
          'feedback',
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            fontSize: JSizes.fontSizeLg,
            weight: FontWeight.w600,
          ),
        ).tr(),
        leadingIcon: Padding(
          padding: const EdgeInsets.all(2.0),
          child: BackCircle(
            isDark: isDark,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Attachment section
            SizedBox(height: 26),

            Text(
              'Attachment',
              style: AppTextStyle.dmSans(
                color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray700,
                fontSize: JSizes.fontSizeMd,
                weight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color:  isDark ? JAppColors.backGroundDarkCard : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? JAppColors.darkGray700 : JAppColors.lightGray300,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          JImages.upload,
                          width: 16,
                          height: 16,
                          colorFilter: ColorFilter.mode(
                            JAppColors.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(

                            text:  easy.tr('clickToUpload'),
                            style: AppTextStyle.dmSans(
                              color: JAppColors.primary,
                              fontSize: 14.0,
                              weight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text:  easy.tr('orDragAndDrop'),
                            style: AppTextStyle.dmSans(
                              color:    isDark ? JAppColors.lightGray300 : JAppColors.darkGray500,
                              fontSize: 14.0,
                              weight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'fileFormats',
                      style: AppTextStyle.dmSans(
                        color:    isDark ? JAppColors.lightGray300 : JAppColors.darkGray500,
                        fontSize: 12.0,
                        weight: FontWeight.w400,
                      ),
                    ).tr(),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Leave a Message section
            Text(
              'leaveMessage',
              style: AppTextStyle.dmSans(
                color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray700,
                fontSize: JSizes.fontSizeMd,
                weight: FontWeight.w500,
              ),
            ).tr(),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                color: isDark ? JAppColors.backGroundDarkCard.withValues(alpha: 0.4) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isDark ? JAppColors.darkGray700 : JAppColors.lightGray400,
                  width: 1,
                ),
              ),
              child: TextField(
                controller: _messageController,
                maxLines: 10,
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray700,
                  fontSize: JSizes.fontSizeSm, weight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText: 'whatYouWantToTalk'.tr(),
                  hintStyle: AppTextStyle.dmSans(
                    color: isDark ? JAppColors.darkGray400 : JAppColors.lightGray600,
                    fontSize: JSizes.fontSizeSm, weight: FontWeight.w400,
                  ),
                  contentPadding: EdgeInsets.all(16),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
              ),
            ),

            // Spacer
            SizedBox(height: 56),

            // Bottom buttons
            Row(
              children: [
                Expanded(
                  child: MainButton(
                    btn_title: 'cancel',
                    btn_radius: 10,
                    btn_color: JAppColors.lightGray100,
                    btn_border_color: Colors.transparent,
                    title_color: Colors.black,
                    text_fontweight: FontWeight.w600,
                    image_value: false,
                    onTap: () {
                      AppRouter.router.push('/chatScreen');
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: MainButton(
                    btn_title: 'deliverNowButton',
                    btn_radius: 10,
                    btn_color: JAppColors.primary,
                    btn_border_color:Colors.transparent,
                    title_color:Colors.white,
                    text_fontweight: FontWeight.w600,
                    image_value: false,
                    onTap: () {
                      AppRouter.router.push('/feedBackScreen');

                    },
                    text_size: JSizes.fontSizeMd,
                  ),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}