import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:job_contracts/utils/common_widgets/main_button.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/data/models/user/update_current_user_profile_req.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../../../../data/repositories/user_repository_impl.dart';
import '../../../../utils/common_widgets/text_field_widget.dart';
import '../providers/current_user_provider.dart';

class ProfileInformationScreen extends StatefulWidget {
  const ProfileInformationScreen({super.key});

  @override
  State<ProfileInformationScreen> createState() => _ProfileInformationScreenState();
}

class _ProfileInformationScreenState extends State<ProfileInformationScreen> {
  bool _isLoading = false;
  bool _hasChanges = false;
  final UserRepositoryImpl _userRepository = UserRepositoryImpl();

  // Controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _phoneNumber = '';
  String _countryCode = 'PK';
  File? _profileImage;
  String? _currentProfileUrl;

  // Original values for comparison
  String? _originalFirstName;
  String? _originalLastName;
  String? _originalDob;
  String? _originalEmail;
  String? _originalPhone;

  @override
  void initState() {
    super.initState();
    _loadCurrentUserData();
    _setupChangeListeners();
  }

  void _setupChangeListeners() {
    _firstNameController.addListener(_checkForChanges);
    _lastNameController.addListener(_checkForChanges);
    _dobController.addListener(_checkForChanges);
    _emailController.addListener(_checkForChanges);
  }

  void _checkForChanges() {
    final hasChanges =
        _firstNameController.text != _originalFirstName ||
            _lastNameController.text != _originalLastName ||
            _dobController.text != _originalDob ||
            _emailController.text != _originalEmail ||
            _phoneNumber != _originalPhone ||
            _profileImage != null;

    if (hasChanges != _hasChanges) {
      setState(() {
        _hasChanges = hasChanges;
      });
    }
  }

  Future<void> _loadCurrentUserData() async {
    try {
      setState(() => _isLoading = true);

      final currentUser = await _userRepository.getCurrentUser();

      if (!mounted) return;

      setState(() {
        // Split fullName if it exists
        if (currentUser.name != null && currentUser.name!.isNotEmpty) {
          final names = currentUser.name!.split(' ');
          _firstNameController.text = names.first;
          _originalFirstName = names.first;

          if (names.length > 1) {
            _lastNameController.text = names.sublist(1).join(' ');
            _originalLastName = names.sublist(1).join(' ');
          }
        }

        _dobController.text = currentUser.dob ?? '';
        _originalDob = currentUser.dob ?? '';

        _emailController.text = currentUser.email ?? '';
        _originalEmail = currentUser.email ?? '';

        _phoneNumber = currentUser.phoneNumber ?? '';
        _originalPhone = currentUser.phoneNumber ?? '';

        _currentProfileUrl = currentUser.profile;

        _isLoading = false;
      });

      debugPrint('✅ User data loaded successfully');
      debugPrint('Name: ${currentUser.name}');
      debugPrint('Email: ${currentUser.email}');
      debugPrint('Phone: ${currentUser.phoneNumber}');
      debugPrint('DOB: ${currentUser.dob}');
      debugPrint('Profile URL: ${currentUser.profile}');
    } catch (e) {
      if (!mounted) return;

      setState(() => _isLoading = false);
      debugPrint('❌ Error loading profile: $e');

      _showErrorSnackBar("Error loading profile: $e");
    }
  }

  Future<void> _pickImage() async {
    try {
      // Show image source selection dialog
      final source = await showModalBottomSheet<ImageSource>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? JAppColors.backGroundDarkCard
                  : Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: SafeArea(
              child: Wrap(
                children: [
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: Text('takePhoto'.tr()),
                    onTap: () => Navigator.pop(context, ImageSource.camera),
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: Text('chooseFromGallery'.tr()),
                    onTap: () => Navigator.pop(context, ImageSource.gallery),
                  ),
                  if (_profileImage != null || _currentProfileUrl != null)
                    ListTile(
                      leading: const Icon(Icons.delete, color: Colors.red),
                      title: Text('removePhoto'.tr(),
                          style: const TextStyle(color: Colors.red)),
                      onTap: () => Navigator.pop(context, null),
                    ),
                  ListTile(
                    leading: const Icon(Icons.cancel),
                    title: Text('cancel'.tr()),
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          );
        },
      );

      if (source == null && _profileImage == null && _currentProfileUrl == null) {
        return;
      }

      // Handle remove photo
      if (source == null) {
        setState(() {
          _profileImage = null;
          _currentProfileUrl = null;
        });
        _checkForChanges();
        return;
      }

      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _profileImage = File(image.path);
        });
        _checkForChanges();
        debugPrint('✅ Image selected: ${image.path}');
      }
    } catch (e) {
      debugPrint('❌ Error picking image: $e');
      if (!mounted) return;

      _showErrorSnackBar("Error selecting image: $e");
    }
  }

  Future<void> _selectDate() async {
    DateTime? initialDate;

    // Parse existing date if available
    if (_dobController.text.isNotEmpty) {
      try {
        final parts = _dobController.text.split('-');
        if (parts.length == 3) {
          initialDate = DateTime(
            int.parse(parts[2]), // year
            int.parse(parts[1]), // month
            int.parse(parts[0]), // day
          );
        }
      } catch (e) {
        debugPrint('Error parsing existing date: $e');
      }
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now().subtract(const Duration(days: 6570)), // 18 years ago
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      helpText: 'selectDateOfBirth'.tr(),
      cancelText: 'cancel'.tr(),
      confirmText: 'ok'.tr(),
    );

    if (picked != null) {
      setState(() {
        // Format as DD-MM-YYYY to match backend format
        _dobController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
      _checkForChanges();
      debugPrint('✅ Date selected: ${_dobController.text}');
    }
  }

  Future<void> _handleSave() async {
    // Validation
    if (_firstNameController.text.trim().isEmpty) {
      _showErrorSnackBar("Please enter first name".tr());
      return;
    }

    if (_emailController.text.trim().isEmpty) {
      _showErrorSnackBar("Please enter email address".tr());
      return;
    }

    // Email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(_emailController.text.trim())) {
      _showErrorSnackBar("Please enter a valid email address".tr());
      return;
    }

    // Phone validation
    if (_phoneNumber.isEmpty) {
      _showErrorSnackBar("Please enter phone number".tr());
      return;
    }

    // Show confirmation dialog
    final confirm = await _showConfirmDialog();
    if (!confirm) return;

    setState(() => _isLoading = true);

    try {
      // Combine first and last name
      final fullName = '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}'.trim();

      debugPrint('📤 Preparing to update profile...');
      debugPrint('Full Name: $fullName');
      debugPrint('Email: ${_emailController.text.trim()}');
      debugPrint('DOB: ${_dobController.text.trim()}');
      debugPrint('Phone: $_phoneNumber');
      debugPrint('Has Profile Image: ${_profileImage != null}');

      final request = UpdateCurrentUserProfileRequest(
        fullName: fullName,
        dob: _dobController.text.trim().isNotEmpty ? _dobController.text.trim() : null,
        email: _emailController.text.trim(),
        phoneNumber: _phoneNumber.isNotEmpty ? _phoneNumber : null,
        profilePicture: _profileImage,
      );

      // Try to use Provider if available, otherwise use repository directly
      bool success = false;
      try {
        final provider = Provider.of<CurrentUserProvider>(context, listen: false);
        success = await provider.updateCurrentUserProfile(request);
      } catch (e) {
        debugPrint('Provider not found, using repository directly: $e');
        final updatedUser = await _userRepository.updateCurrentUserProfile(request);
        success = true;
        debugPrint('✅ Profile updated via repository: ${updatedUser.name}');
      }

      if (!mounted) return;

      setState(() => _isLoading = false);

      if (success) {
        debugPrint('✅ Profile update completed successfully');

        // Reset change tracking
        _originalFirstName = _firstNameController.text;
        _originalLastName = _lastNameController.text;
        _originalDob = _dobController.text;
        _originalEmail = _emailController.text;
        _originalPhone = _phoneNumber;
        _profileImage = null;
        _hasChanges = false;

        _showSuccessSnackBar("Profile updated successfully".tr());

        // Optional: Navigate back after delay
        await Future.delayed(const Duration(milliseconds: 1500));
        if (!mounted) return;
        Navigator.pop(context, true);
      }

    } catch (e) {
      if (!mounted) return;

      setState(() => _isLoading = false);

      debugPrint('❌ Failed to update profile: $e');
      _showErrorSnackBar("Failed to update profile: ${e.toString().replaceAll('Exception: ', '')}");
    }
  }

  Future<bool> _showConfirmDialog() async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return AlertDialog(
          backgroundColor: isDark ? JAppColors.backGroundDarkCard : Colors.white,
          title: Text('confirmUpdate'.tr()),
          content: Text('areYouSureYouWantToUpdateYourProfile'.tr()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('cancel'.tr(),
                  style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: JAppColors.main,
              ),
              child: Text('update'.tr(),
                  style: const TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    ) ?? false;
  }

  Future<bool> _onWillPop() async {
    if (!_hasChanges) return true;

    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return AlertDialog(
          backgroundColor: isDark ? JAppColors.backGroundDarkCard : Colors.white,
          title: Text('discardChanges'.tr()),
          content: Text('youHaveUnsavedChangesDoYouWantToDiscard'.tr()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('cancel'.tr(),
                  style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text('discard'.tr(),
                  style: const TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    ) ?? false;
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _resetForm() {
    setState(() {
      _firstNameController.text = _originalFirstName ?? '';
      _lastNameController.text = _originalLastName ?? '';
      _dobController.text = _originalDob ?? '';
      _emailController.text = _originalEmail ?? '';
      _phoneNumber = _originalPhone ?? '';
      _profileImage = null;
      _hasChanges = false;
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Widget _buildProfileImage(bool isDark) {
    return Center(
      child: Stack(
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: JAppColors.main,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: JAppColors.main.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[300],
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!)
                    : (_currentProfileUrl != null && _currentProfileUrl!.isNotEmpty)
                    ? CachedNetworkImageProvider(_currentProfileUrl!) as ImageProvider
                    : null,
                child: (_profileImage == null && (_currentProfileUrl == null || _currentProfileUrl!.isEmpty))
                    ? Icon(Icons.person, size: 60, color: Colors.grey[600])
                    : null,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: _pickImage,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: JAppColors.main,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDark ? JAppColors.backGroundDark : Colors.white,
                    width: 3,
                  ),
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
        appBar: AppBar(
          title: Text('profileInfo'.tr()),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              if (await _onWillPop()) {
                Navigator.pop(context);
              }
            },
          ),
          actions: [
            if (_hasChanges)
              IconButton(
                icon: const Icon(Icons.refresh),
                tooltip: 'reset'.tr(),
                onPressed: _resetForm,
              ),
          ],
        ),
        body: _isLoading
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                'updatingProfile'.tr(),
                style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.black54,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        )
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Image Picker
                _buildProfileImage(isDark),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    'tapToChangeProfilePicture'.tr(),
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.white54 : Colors.black45,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Form Fields
                // First Name
                TextFieldWidget(
                  textEditingController: _firstNameController,
                  subTitle: 'firstName',
                  hintText: 'e.g john'.tr(),
                  subtitleColor: isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                  titleColor: isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                ),
                const SizedBox(height: 16),

                // Last Name
                TextFieldWidget(
                  textEditingController: _lastNameController,
                  subTitle: 'lastName',
                  hintText: 'e.g doe'.tr(),
                  subtitleColor: isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                  titleColor: isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                ),
                const SizedBox(height: 16),

                // Date of Birth
                TextFieldWidget(
                  textEditingController: _dobController,
                  subTitle: 'dateOfBirth',
                  hintText: '12-12-1995'.tr(),
                  subtitleColor: isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                  titleColor: isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                  suffixIcon: const Icon(Icons.calendar_month_outlined),
                  readOnly: true,
                  onTap: _selectDate,
                ),
                const SizedBox(height: 16),

                // Email
                TextFieldWidget(
                  textEditingController: _emailController,
                  subTitle: 'emailAddress',
                  hintText: 'e.g johndev@gmail.com',
                  subtitleColor: isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                  titleColor: isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),

                // Phone Number
                Text(
                  'phone'.tr(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? JAppColors.lightGray100 : JAppColors.lightGray800,
                  ),
                ),
                const SizedBox(height: 8),
                IntlPhoneField(
                  decoration: InputDecoration(
                    fillColor: isDark ? JAppColors.backGroundDarkCard : Colors.transparent,
                    filled: true,
                    border: const OutlineInputBorder(),
                  ),
                  initialCountryCode: _countryCode,
                  initialValue: _phoneNumber.replaceAll(_countryCode, '').replaceAll('+', ''),
                  onChanged: (phone) {
                    _phoneNumber = phone.completeNumber;
                    _checkForChanges();
                    debugPrint('Phone number changed: $_phoneNumber');
                  },
                  onCountryChanged: (country) {
                    _countryCode = country.code;
                    debugPrint('Country changed: ${country.name} (${country.code})');
                  },
                ),
                const SizedBox(height: 32),

                // Save Button
                MainButton(
                  onTap: (_isLoading || !_hasChanges) ? null : _handleSave,
                  btn_title: 'save'.tr(),
                  btn_radius: 10,
                  btn_color: _hasChanges ? JAppColors.main : Colors.grey,
                  title_color: Colors.white,
                  image_value: false,
                ),

                if (_hasChanges)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Center(
                      child: Text(
                        'youHaveUnsavedChanges'.tr(),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.orange,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}