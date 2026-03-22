import 'dart:io';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/data_source/local/AuthPreferences.dart';
import '../../../../data/models/blog/CreateBlogRequest.dart';
import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/main_button.dart';
import '../../../../utils/common_widgets/circular_avatar.dart';
import '../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../providers/BlogProvider.dart';
import 'provider/blog_provider.dart';

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

  File? _selectedImage;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        setState(() => _selectedImage = File(pickedFile.path));
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: JAppColors.error600,
        ),
      );
    }
  }

  Future<void> _submit(BlogProvider blogProvider) async {
    if (!_formKey.currentState!.validate()) return;

    // ── Get authorId from stored user ──────────────────────────────────────
    final user = await AuthPreferences.getUser();
    if (user == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('User not logged in. Please login again.'),
          backgroundColor: JAppColors.error600,
        ),
      );
      return;
    }

    final tags = _tagsController.text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    // ✅ Use CreateBlogRequest — matches BlogProvider.createBlog()
    final request = CreateBlogRequest(
      authorId: user.id,
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      tags: tags,
      image: _selectedImage, // nullable — OK if no image selected
    );

    final success = await blogProvider.createBlog(request);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('blog_created_success'.tr()),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(blogProvider.errorMessage ?? 'blog_create_failed'.tr()),
          backgroundColor: JAppColors.error600,
        ),
      );
    }
  }

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
          'Create Blog',
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
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Consumer<BlogProvider>(
              builder: (context, blogProvider, _) {
                // ✅ Use isCreating (not isLoading) for submit button state
                final isBusy = blogProvider.isCreating;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create Blog',
                      style: AppTextStyle.dmSans(
                        fontSize: 20.0,
                        weight: FontWeight.w700,
                        color: isDark
                            ? JAppColors.lightGray100
                            : JAppColors.darkGray900,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ── Title ────────────────────────────────────────────────
                    TextFieldWidget(
                      subTitle: 'Blog Title',
                      hintText: 'Enter your Blog Title...',
                      textEditingController: _titleController,
                      isRequired: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'blog_title_required'.tr();
                        }
                        return null;
                      },
                      subtitleColor: isDark
                          ? JAppColors.lightGray100
                          : JAppColors.darkGray800,
                      titleColor: isDark
                          ? JAppColors.lightGray100
                          : JAppColors.darkGray800,
                    ),

                    // ── Content ──────────────────────────────────────────────
                    const SizedBox(height: 12),
                    TextFieldWidget(
                      subTitle: 'Blog Content',
                      hintText: 'Write your Blog Content...',
                      textEditingController: _contentController,
                      maxLines: 10,
                      isRequired: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'blog_content_required'.tr();
                        }
                        return null;
                      },
                      subtitleColor: isDark
                          ? JAppColors.lightGray100
                          : JAppColors.darkGray800,
                      titleColor: isDark
                          ? JAppColors.lightGray100
                          : JAppColors.darkGray800,
                    ),

                    // ── Tags ─────────────────────────────────────────────────
                    const SizedBox(height: 20),
                    TextFieldWidget(
                      subTitle: 'Blog Tags (Max 5, comma separated)',
                      hintText: 'e.g. flutter, dart, mobile',
                      textEditingController: _tagsController,
                      subtitleColor: isDark
                          ? JAppColors.lightGray100
                          : JAppColors.darkGray800,
                      titleColor: isDark
                          ? JAppColors.lightGray100
                          : JAppColors.darkGray800,
                    ),

                    // ── Featured Image ───────────────────────────────────────
                    const SizedBox(height: 20),
                    Text(
                      'Featured Image',
                      style: AppTextStyle.dmSans(
                        fontSize: 14.0,
                        weight: FontWeight.w600,
                        color: isDark
                            ? JAppColors.darkGray100
                            : JAppColors.darkGray800,
                      ),
                    ),
                    const SizedBox(height: 16),

                    _selectedImage != null
                        ? _buildSelectedImageWidget(isDark)
                        : _buildImageUploadBox(isDark),

                    const SizedBox(height: 20),

                    // ── Submit Button ────────────────────────────────────────
                    MainButton(
                      btn_title: isBusy ? 'Creating...' : 'Create Blog',
                      btn_radius: 12,
                      buttonType: MainButtonType.primary,
                      title_color: Colors.white,
                      text_fontweight: FontWeight.w700,
                      image_value: false,
                      // ✅ disable while creating
                      onTap: isBusy ? null : () => _submit(blogProvider),
                      text_size: JSizes.fontSizeMd,
                    ),

                    const SizedBox(height: 24),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedImageWidget(bool isDark) {
    return GestureDetector(
      onTap: _pickImageFromGallery,
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray400,
            width: 1.2,
          ),
        ),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: FileImage(_selectedImage!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: JAppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.edit, color: Colors.white, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageUploadBox(bool isDark) {
    return DottedBorder(
      color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray400,
      strokeWidth: 1.2,
      dashPattern: const [6, 4],
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          color: isDark ? JAppColors.darkGray700 : JAppColors.lightGray100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_upload_outlined,
                size: 42,
                color: isDark ? JAppColors.darkGray200 : JAppColors.lightGray600,
              ),
              const SizedBox(height: 12),
              Text(
                'Drag & Drop or Select',
                style: AppTextStyle.dmSans(
                  fontSize: 13.0,
                  weight: FontWeight.w400,
                  color: isDark ? JAppColors.darkGray200 : JAppColors.lightGray700,
                ),
              ),
              const SizedBox(height: 12),
              MainButton(
                width: 150,
                height: 40,
                btn_title: 'Select Image',
                btn_radius: 12,
                buttonType: MainButtonType.primary,
                btn_color: isDark
                    ? JAppColors.darkGray400
                    : JAppColors.lightGray300,
                title_color:
                isDark ? JAppColors.darkGray100 : JAppColors.darkGray900,
                text_fontweight: FontWeight.w700,
                image_value: false,
                onTap: _pickImageFromGallery,
                text_size: JSizes.fontSizeMd,
              ),
            ],
          ),
        ),
      ),
    );
  }
}