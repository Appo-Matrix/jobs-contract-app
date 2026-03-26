import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../account_screen/bottomsheet/showLanguageBottomSheet.dart';
import '../../providers/language_provider.dart';

class LanguagesList extends StatelessWidget {
  final bool isDark;

  const LanguagesList({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LanguageProvider>();
    final languages = provider.languages;

    if (provider.isLoading) {
      return const SizedBox(
        height: 36,
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    if (languages.isEmpty) {
      return Text(
        'No languages added yet.',
        style: AppTextStyle.dmSans(
          fontSize: JSizes.fontSizeSm,
          weight: FontWeight.w400,
          color: isDark ? JAppColors.darkGray400 : JAppColors.lightGray500,
        ),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: languages.map((lang) {
        return _LanguageChip(
          id: lang.id ?? '',
          name: lang.name,
          proficiency: lang.proficiency,
          isDark: isDark,
          onEdit: () => showLanguageBottomSheet(
            context,
            isDark,
            existingLanguage: lang, // ← opens in edit mode
          ),
          onDelete: () async {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Remove Language'),
                content: Text(
                    'Remove "${lang.name}" from your profile?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text(
                      'Remove',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            );
            if (confirm == true && context.mounted) {
              context
                  .read<LanguageProvider>()
                  .deleteLanguage(lang.id ?? '');
            }
          },
        );
      }).toList(),
    );
  }
}

class _LanguageChip extends StatelessWidget {
  final String id;
  final String name;
  final String proficiency;
  final bool isDark;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _LanguageChip({
    required this.id,
    required this.name,
    required this.proficiency,
    required this.isDark,
    required this.onEdit,
    required this.onDelete,
  });

  String get _displayProficiency =>
      proficiency.isEmpty
          ? ''
          : proficiency[0].toUpperCase() + proficiency.substring(1);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onEdit, // tap to edit
      onLongPress: onDelete, // long press to delete
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isDark ? JAppColors.darkGray700 : JAppColors.lightGray200,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name,
              style: AppTextStyle.dmSans(
                fontSize: 12.0,
                weight: FontWeight.w500,
                color: isDark
                    ? JAppColors.darkGray200
                    : JAppColors.lightGray700,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '• $_displayProficiency',
              style: AppTextStyle.dmSans(
                fontSize: 12.0,
                weight: FontWeight.w400,
                color: isDark
                    ? JAppColors.darkGray400
                    : JAppColors.lightGray500,
              ),
            ),
            const SizedBox(width: 6),
            // Edit icon
            Icon(
              Icons.edit,
              size: 12,
              color: isDark
                  ? JAppColors.darkGray400
                  : JAppColors.lightGray400,
            ),
          ],
        ),
      ),
    );
  }
}