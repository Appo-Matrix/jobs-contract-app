import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/main_button.dart';
import '../../../../utils/common_widgets/circular_avatar.dart';
import '../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';

class BlogCreateScreen extends StatefulWidget {
  const BlogCreateScreen({super.key});

  @override
  State<BlogCreateScreen> createState() => _BlogCreateScreenState();
}

class _BlogCreateScreenState extends State<BlogCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _tagsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.darkBackground : Colors.white,

      appBar: JAppbar(
        leadingIcon: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_back,
              color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
              size: 24,
            ),
          ),
        ),

        title: Text(
          'Create New Blog',
          style: AppTextStyle.dmSans(
            fontSize: 18.0,
            weight: FontWeight.w600,
            color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray900,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircularAvatar(
              isDark: isDark,
              radius: 18,
              imageUrl: JImages.image,
            ),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create New Blog",
                  style: AppTextStyle.dmSans(
                    fontSize: 20.0,
                    weight: FontWeight.w700,
                    color:
                        isDark
                            ? JAppColors.lightGray100
                            : JAppColors.darkGray900,
                  ),
                ),
                const SizedBox(height: 24),

                TextFieldWidget(
                  subTitle: 'Blog Title',
                  hintText: 'Enter your Blog Title...',
                  subtitleColor:
                      isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                  titleColor:
                      isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                ),

                /// --- Blog Content ---
                const SizedBox(height: 12),
                TextFieldWidget(
                  subTitle: 'Blog Content',
                  hintText: 'Write your Blog Content...',
                  maxLines: 10,
                  subtitleColor:
                      isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                  titleColor:
                      isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                ),

                const SizedBox(height: 20),

                /// --- Blog Tags ---
                ///
                TextFieldWidget(
                  subTitle: 'log Tags (Max 5)',
                  hintText: 'Type a Blog Tags',

                  subtitleColor:
                      isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                  titleColor:
                      isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                ),

                const SizedBox(height: 20),

                /// --- Featured Image ---
                Text(
                  'Featured Image',
                  style: AppTextStyle.dmSans(
                    fontSize: 14.0,
                    weight: FontWeight.w600,
                    color:
                        isDark
                            ? JAppColors.darkGray100
                            : JAppColors.darkGray800,
                  ),
                ),
                const SizedBox(height: 16),
                DottedBorder(
                  color:
                      isDark ? JAppColors.darkGray300 : JAppColors.lightGray400,
                  strokeWidth: 1.2,
                  dashPattern: const [6, 4],
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  child: Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      color:
                          isDark
                              ? JAppColors.darkGray700
                              : JAppColors.lightGray100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            size: 42,
                            color:
                                isDark
                                    ? JAppColors.darkGray200
                                    : JAppColors.lightGray600,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Drag & drop your featured image here,\nor click to browse",
                            textAlign: TextAlign.center,
                            style: AppTextStyle.dmSans(
                              fontSize: 13.0,
                              weight: FontWeight.w400,
                              color:
                                  isDark
                                      ? JAppColors.darkGray200
                                      : JAppColors.lightGray700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          MainButton(
                            width: 150,
                            height: 40,
                            btn_title: "Select Image",
                            btn_radius: 12,
                            buttonType: MainButtonType.primary,
                            btn_color:
                                isDark
                                    ? JAppColors.darkGray400
                                    : JAppColors.lightGray300,
                            title_color:
                                isDark
                                    ? JAppColors.darkGray100
                                    : JAppColors.darkGray900,
                            text_fontweight: FontWeight.w700,
                            image_value: false,
                            onTap: () {},
                            text_size: JSizes.fontSizeMd,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const SizedBox(height: 12),
                const SizedBox(height: 12),
                MainButton(
                  btn_title: "Create Blog",
                  btn_radius: 12,
                  buttonType: MainButtonType.primary,
                  title_color: Colors.white,
                  text_fontweight: FontWeight.w700,
                  image_value: false,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Blog Created Successfully!"),
                        ),
                      );
                    }
                  },
                  text_size: JSizes.fontSizeMd,
                ),

                const SizedBox(height: 12),
                const SizedBox(height: 12),
                const SizedBox(height: 12),
                const SizedBox(height: 12),
                const SizedBox(height: 12),
                const SizedBox(height: 12),
                const SizedBox(height: 12),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
