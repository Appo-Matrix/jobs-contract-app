import 'package:flutter/material.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../data/models/auth/login_res.dart';

class UserInfoCard extends StatelessWidget {
  final User user;
  final bool isDark;
  final VoidCallback? onEditPhone;
  final VoidCallback? onEditTitle;
  final VoidCallback? onEditCity;
  final VoidCallback? onEditCountry;
  final VoidCallback? onEditService;
  final VoidCallback? onEditSpecialty;

  const UserInfoCard({
    super.key,
    required this.user,
    required this.isDark,
    this.onEditPhone,
    this.onEditTitle,
    this.onEditCity,
    this.onEditCountry,
    this.onEditService,
    this.onEditSpecialty,
  });

  @override
  Widget build(BuildContext context) {
    // Collect only the rows that have something to show
    final List<Widget> rows = [];

    void addDividerIfNeeded() {
      if (rows.isNotEmpty) rows.add(const Divider(height: 20));
    }

    // ── Email — always shown (login identifier, always present) ────────────
    rows.add(_InfoRow(
      icon: Icons.email_outlined,
      label: 'Email',
      value: user.email,
      isDark: isDark,
    ));

    // ── Phone — shown with value OR "Not yet added" + edit icon ───────────
    addDividerIfNeeded();
    rows.add(_InfoRow(
      icon: Icons.phone_outlined,
      label: 'Phone',
      value: user.phoneNumber.isNotEmpty ? user.phoneNumber : 'Not yet added',
      isDark: isDark,
      isEmpty: user.phoneNumber.isEmpty,
      onEdit: onEditPhone,
    ));

    // ── Title — shown with value OR "Not yet added" + edit icon ───────────
    addDividerIfNeeded();
    rows.add(_InfoRow(
      icon: Icons.badge_outlined,
      label: 'Title',
      value: user.title.isNotEmpty ? user.title : 'Not yet added',
      isDark: isDark,
      isEmpty: user.title.isEmpty,
      onEdit: onEditTitle,
    ));

    // ── City — shown with value OR "Not yet added" + edit icon ────────────
    addDividerIfNeeded();
    rows.add(_InfoRow(
      icon: Icons.location_city_outlined,
      label: 'City',
      value: user.city.isNotEmpty ? user.city : 'Not yet added',
      isDark: isDark,
      isEmpty: user.city.isEmpty,
      onEdit: onEditCity,
    ));

    // ── Country — shown with value OR "Not yet added" + edit icon ─────────
    addDividerIfNeeded();
    rows.add(_InfoRow(
      icon: Icons.flag_outlined,
      label: 'Country',
      value: user.country.isNotEmpty ? user.country : 'Not yet added',
      isDark: isDark,
      isEmpty: user.country.isEmpty,
      onEdit: onEditCountry,
    ));

    // ── State — only shown if has value (read-only, no edit icon) ─────────
    if (user.stateOrProvince.isNotEmpty) {
      addDividerIfNeeded();
      rows.add(_InfoRow(
        icon: Icons.map_outlined,
        label: 'State',
        value: user.stateOrProvince,
        isDark: isDark,
      ));
    }

    // ── Street — only shown if has value ──────────────────────────────────
    if (user.streetAndNumber.isNotEmpty) {
      addDividerIfNeeded();
      rows.add(_InfoRow(
        icon: Icons.signpost_outlined,
        label: 'Street',
        value: user.streetAndNumber,
        isDark: isDark,
      ));
    }

    // ── Postal Code — only shown if has value ─────────────────────────────
    if (user.postalCode.isNotEmpty) {
      addDividerIfNeeded();
      rows.add(_InfoRow(
        icon: Icons.markunread_mailbox_outlined,
        label: 'Postal',
        value: user.postalCode,
        isDark: isDark,
      ));
    }

    // ── Service Type — shown with value OR "Not yet added" + edit icon ────
    addDividerIfNeeded();
    rows.add(_InfoRow(
      icon: Icons.work_outline,
      label: 'Service',
      value: user.serviceType.isNotEmpty ? user.serviceType : 'Not yet added',
      isDark: isDark,
      isEmpty: user.serviceType.isEmpty,
      onEdit: onEditService,
    ));

    // ── Specialty — shown with value OR "Not yet added" + edit icon ───────
    addDividerIfNeeded();
    rows.add(_InfoRow(
      icon: Icons.auto_fix_high_outlined,
      label: 'Specialty',
      value: user.specialty.isNotEmpty ? user.specialty : 'Not yet added',
      isDark: isDark,
      isEmpty: user.specialty.isEmpty,
      onEdit: onEditSpecialty,
    ));

    // ── Years of Experience — only shown if > 0 (read-only) ───────────────
    if (user.yearsOfExperience > 0) {
      addDividerIfNeeded();
      rows.add(_InfoRow(
        icon: Icons.star_outline,
        label: 'Experience',
        value: '${user.yearsOfExperience} yrs',
        isDark: isDark,
      ));
    }

    // ── Service Range — only shown if has value (read-only) ───────────────
    if (user.serviceRange.isNotEmpty) {
      addDividerIfNeeded();
      rows.add(_InfoRow(
        icon: Icons.radar,
        label: 'Range',
        value: user.serviceRange,
        isDark: isDark,
      ));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark
              ? JAppColors.darkGray800.withOpacity(0.6)
              : JAppColors.lightGray100,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDark
                ? JAppColors.darkGray600.withOpacity(0.3)
                : JAppColors.lightGray300,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rows,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _InfoRow
// ─────────────────────────────────────────────────────────────────────────────
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isDark;
  final VoidCallback? onEdit; // null = read-only row
  final bool isEmpty;         // true = value is "Not yet added"

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.isDark,
    this.onEdit,
    this.isEmpty = false,
  });

  @override
  Widget build(BuildContext context) {
    // Value colour: muted when empty, normal when filled
    final Color valueColor = isEmpty
        ? (isDark ? JAppColors.darkGray500 : JAppColors.lightGray400)
        : (isDark ? JAppColors.darkGray100 : JAppColors.lightGray800);

    return GestureDetector(
      onTap: onEdit,
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray500,
          ),
          const SizedBox(width: 10),
          Text(
            '$label:',
            style: AppTextStyle.dmSans(
              fontSize: 13,
              weight: FontWeight.w500,
              color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray500,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.dmSans(
                fontSize: 13,
                weight: FontWeight.w400,
                color: valueColor,
              ),
            ),
          ),
          // Edit icon only for editable rows
          if (onEdit != null) ...[
            const SizedBox(width: 4),
            Icon(
              Icons.edit_outlined,
              size: 15,
              color: isDark ? JAppColors.darkGray400 : JAppColors.lightGray400,
            ),
          ],
        ],
      ),
    );
  }
}