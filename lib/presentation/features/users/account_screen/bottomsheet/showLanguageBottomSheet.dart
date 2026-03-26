import 'package:custom_language_picker/custom_language_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../data/models/language/language_model.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../providers/language_provider.dart';

Future<void> showLanguageBottomSheet(
    BuildContext context,
    bool isDark, {
      LanguageModel? existingLanguage,
    }) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => _LanguageSheet(
      isDark: isDark,
      existingLanguage: existingLanguage,
    ),
  );
}

class _LanguageSheet extends StatefulWidget {
  final bool isDark;
  final LanguageModel? existingLanguage;

  const _LanguageSheet({
    required this.isDark,
    this.existingLanguage,
  });

  @override
  State<_LanguageSheet> createState() => _LanguageSheetState();
}

class _LanguageSheetState extends State<_LanguageSheet> {
  static const List<String> _proficiencyLevels = [
    'basic',
    'conversational',
    'fluent',
    'native',
  ];

  Language? _selectedLanguage;
  String? _selectedProficiency;
  bool _isSaving = false;
  bool _isDeleting = false;
  LanguageModel? _editingLanguage;

  bool get _isEditMode => _editingLanguage != null;
  bool get _busy => _isSaving || _isDeleting;

  @override
  void initState() {
    super.initState();
    if (widget.existingLanguage != null) {
      _startEditing(widget.existingLanguage!);
    }
  }

  void _startEditing(LanguageModel lang) {
    setState(() {
      _editingLanguage = lang;
      // Find matching Language from custom_language_picker by name
      try {
        _selectedLanguage = Languages.defaultLanguages.firstWhere(
              (l) => l.name.toLowerCase() == lang.name.toLowerCase(),
        );
      } catch (_) {
        _selectedLanguage = null;
      }
      _selectedProficiency = lang.proficiency.toLowerCase();
    });
  }

  void _clearForm() {
    setState(() {
      _editingLanguage = null;
      _selectedLanguage = null;
      _selectedProficiency = null;
    });
  }

  String _proficiencyLabel(String p) =>
      p.isEmpty ? '' : p[0].toUpperCase() + p.substring(1);

  // ── Open the dialog picker ────────────────────────────────────────────────
  void _openLanguagePicker() {
    showDialog(
      context: context,
      builder: (ctx) => CustomLanguagePickerDialog(
        titleText: 'Select Language',
        isSearchable: true,
        searchHintText: 'Search languages...',
        showNativeNames: true,

        // Match app theme
        headerBackgroundColor: JAppColors.primary,
        headerTextColor: Colors.white,
        closeIconColor: Colors.white,
        dialogBorderRadius: 16,
        dialogBackgroundColor:
        widget.isDark ? JAppColors.backGroundDark : Colors.white,
        searchFocusedBorderColor: JAppColors.primary,
        searchIconColor: JAppColors.primary,
        selectedItemBackgroundColor: JAppColors.primary.withOpacity(0.1),
        selectedItemTextColor: JAppColors.primary,
        selectedItemBorderColor: JAppColors.primary,

        onValuePicked: (Language language) {
          setState(() => _selectedLanguage = language);
        },
      ),
    );
  }

  // ── Save ──────────────────────────────────────────────────────────────────
  Future<void> _save() async {
    if (_selectedLanguage == null && !_isEditMode) {
      _showError('Please select a language.');
      return;
    }
    if (_selectedProficiency == null) {
      _showError('Please select a proficiency level.');
      return;
    }

    setState(() => _isSaving = true);
    final provider = context.read<LanguageProvider>();
    bool success = false;

    if (_isEditMode) {
      final model = LanguageModel(
        id: _editingLanguage!.id,
        name: _selectedLanguage?.name ?? _editingLanguage!.name,
        proficiency: _selectedProficiency!,
        userId: _editingLanguage!.userId,
      );
      success =
      await provider.updateLanguage(_editingLanguage!.id!, model);
    } else {
      final model = LanguageModel(
        name: _selectedLanguage!.name,
        proficiency: _selectedProficiency!,
      );
      success = await provider.addLanguage(model);
    }

    if (mounted) {
      setState(() => _isSaving = false);
      if (success) _clearForm();
    }
  }

  // ── Delete ────────────────────────────────────────────────────────────────
  Future<void> _delete(LanguageModel lang) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Remove Language'),
        content: Text('Remove "${lang.name}" from your profile?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Remove',
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm != true || !mounted) return;

    setState(() => _isDeleting = true);
    await context.read<LanguageProvider>().deleteLanguage(lang.id!);

    if (mounted) {
      setState(() => _isDeleting = false);
      if (_editingLanguage?.id == lang.id) _clearForm();
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    final provider = context.watch<LanguageProvider>();
    final myLanguages = provider.languages;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (ctx, scrollController) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: ListView(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            // ── Handle bar ─────────────────────────────────────────────────
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark
                        ? JAppColors.darkGray500
                        : JAppColors.lightGray300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),

            // ── Title ──────────────────────────────────────────────────────
            Text(
              'Manage Languages',
              style: AppTextStyle.dmSans(
                fontSize: 18.0,
                weight: FontWeight.w700,
                color: isDark
                    ? JAppColors.darkGray100
                    : JAppColors.lightGray800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Tap a language to edit it',
              style: AppTextStyle.dmSans(
                fontSize: JSizes.fontSizeSm,
                weight: FontWeight.w400,
                color: isDark
                    ? JAppColors.darkGray300
                    : JAppColors.lightGray600,
              ),
            ),
            const SizedBox(height: 16),

            // ── My languages list ──────────────────────────────────────────
            if (provider.isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            else if (myLanguages.isEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  'No languages added yet.',
                  style: AppTextStyle.dmSans(
                    fontSize: JSizes.fontSizeSm,
                    weight: FontWeight.w400,
                    color: isDark
                        ? JAppColors.darkGray400
                        : JAppColors.lightGray500,
                  ),
                ),
              )
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: myLanguages.map((lang) {
                  final isBeingEdited = _editingLanguage?.id == lang.id;

                  // Find flag emoji for this language
                  String flagEmoji = '';
                  try {
                    final found = Languages.defaultLanguages.firstWhere(
                          (l) =>
                      l.name.toLowerCase() == lang.name.toLowerCase(),
                    );
                    flagEmoji = '${found.flagEmoji} ';
                  } catch (_) {}

                  return GestureDetector(
                    onTap: () => _startEditing(lang),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: isBeingEdited
                            ? JAppColors.primary.withOpacity(0.12)
                            : (isDark
                            ? JAppColors.darkGray700
                            : JAppColors.lightGray200),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: isBeingEdited
                              ? JAppColors.primary
                              : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Flag + name + proficiency
                          Text(
                            '$flagEmoji${lang.name}',
                            style: AppTextStyle.dmSans(
                              fontSize: 12.0,
                              weight: FontWeight.w500,
                              color: isBeingEdited
                                  ? JAppColors.primary
                                  : (isDark
                                  ? JAppColors.darkGray200
                                  : JAppColors.lightGray700),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '• ${_proficiencyLabel(lang.proficiency)}',
                            style: AppTextStyle.dmSans(
                              fontSize: 12.0,
                              weight: FontWeight.w400,
                              color: isBeingEdited
                                  ? JAppColors.primary.withOpacity(0.7)
                                  : (isDark
                                  ? JAppColors.darkGray400
                                  : JAppColors.lightGray500),
                            ),
                          ),
                          const SizedBox(width: 6),
                          // × delete button
                          GestureDetector(
                            onTap: _busy ? null : () => _delete(lang),
                            child: Icon(
                              Icons.close,
                              size: 13,
                              color: isDark
                                  ? JAppColors.darkGray400
                                  : JAppColors.lightGray400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

            const Divider(height: 32),

            // ── Form title ─────────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _isEditMode ? 'Edit Language' : 'Add New Language',
                  style: AppTextStyle.dmSans(
                    fontSize: JSizes.fontSizeMd,
                    weight: FontWeight.w600,
                    color: isDark
                        ? JAppColors.darkGray100
                        : JAppColors.lightGray800,
                  ),
                ),
                if (_isEditMode)
                  TextButton(
                    onPressed: _busy ? null : _clearForm,
                    child: Text(
                      'Add new instead',
                      style: AppTextStyle.dmSans(
                        fontSize: JSizes.fontSizeSm,
                        weight: FontWeight.w500,
                        color: JAppColors.primary,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),

            // ── Language selector button ───────────────────────────────────
            Text(
              'Language',
              style: AppTextStyle.dmSans(
                fontSize: JSizes.fontSizeSm,
                weight: FontWeight.w600,
                color: isDark
                    ? JAppColors.darkGray200
                    : JAppColors.lightGray700,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _openLanguagePicker,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: isDark
                      ? JAppColors.backGroundDarkCard
                      : JAppColors.lightGray100,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _selectedLanguage != null
                        ? JAppColors.primary
                        : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    // Show flag emoji if a language is selected
                    if (_selectedLanguage != null) ...[
                      Text(
                        _selectedLanguage!.flagEmoji,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 10),
                    ],
                    Expanded(
                      child: Text(
                        _selectedLanguage != null
                            ? _selectedLanguage!.name
                            : (_isEditMode
                            ? _editingLanguage!.name
                            : 'Tap to select a language'),
                        style: AppTextStyle.dmSans(
                          fontSize: JSizes.fontSizeMd,
                          weight: FontWeight.w400,
                          color: _selectedLanguage != null
                              ? (isDark
                              ? JAppColors.darkGray100
                              : JAppColors.lightGray800)
                              : (isDark
                              ? JAppColors.darkGray400
                              : JAppColors.lightGray500),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: isDark
                          ? JAppColors.darkGray300
                          : JAppColors.lightGray500,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ── Proficiency chips ──────────────────────────────────────────
            Text(
              'Proficiency Level',
              style: AppTextStyle.dmSans(
                fontSize: JSizes.fontSizeSm,
                weight: FontWeight.w600,
                color: isDark
                    ? JAppColors.darkGray200
                    : JAppColors.lightGray700,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _proficiencyLevels.map((level) {
                final isSelected = _selectedProficiency == level;
                return GestureDetector(
                  onTap: () =>
                      setState(() => _selectedProficiency = level),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? JAppColors.primary
                          : (isDark
                          ? JAppColors.backGroundDarkCard
                          : JAppColors.lightGray100),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected
                            ? JAppColors.primary
                            : (isDark
                            ? JAppColors.darkGray600
                            : JAppColors.lightGray300),
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      _proficiencyLabel(level),
                      style: AppTextStyle.dmSans(
                        fontSize: JSizes.fontSizeSm,
                        weight: FontWeight.w500,
                        color: isSelected
                            ? Colors.white
                            : (isDark
                            ? JAppColors.darkGray200
                            : JAppColors.lightGray700),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),

            // ── Buttons ────────────────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed:
                    _busy ? null : () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(
                        color: isDark
                            ? JAppColors.darkGray400
                            : JAppColors.lightGray400,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Done',
                      style: AppTextStyle.dmSans(
                        fontSize: JSizes.fontSizeMd,
                        weight: FontWeight.w600,
                        color: isDark
                            ? JAppColors.darkGray200
                            : JAppColors.lightGray700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _busy ? null : _save,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: JAppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: _isSaving
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : Text(
                      _isEditMode ? 'Update' : 'Add Language',
                      style: AppTextStyle.dmSans(
                        fontSize: JSizes.fontSizeMd,
                        weight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}