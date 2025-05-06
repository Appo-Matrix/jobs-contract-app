import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:provider/provider.dart';

import '../../../../../theme_controller/ThemeNotifier.dart';

class AppBottomSheets {
  // Theme Bottom Sheet
  static void showThemeBottomSheet(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ThemeBottomSheetContent(isDark: isDark);
      },
    );
  }

  // Language Bottom Sheet
  static void showLanguageBottomSheet(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return LanguageBottomSheetContent(isDark: isDark);
      },
    );
  }
}

// Separate widget for Theme Bottom Sheet content
class ThemeBottomSheetContent extends StatelessWidget {
  final bool isDark;

  const ThemeBottomSheetContent({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'chooseTheme',
            style: AppTextStyle.dmSans(
              fontSize: 18.0,
              weight: FontWeight.bold,
              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            ),
          ).tr(),
          ListTile(
            leading: Icon(Icons.light_mode, color: Colors.orange),
            title: Text('lightTheme').tr(),
            onTap: () {
              Provider.of<ThemeNotifier>(context, listen: false)
                  .toggleTheme(false);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.dark_mode, color: Colors.blueGrey),
            title: Text('darkTheme').tr(),
            onTap: () {
              Provider.of<ThemeNotifier>(context, listen: false)
                  .toggleTheme(true);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.brightness_auto, color: Colors.green),
            title: Text('systemDefault').tr(),
            onTap: () {
              // Pass null to indicate system theme
              Provider.of<ThemeNotifier>(context, listen: false)
                  .toggleTheme(null);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

// Separate widget for Language Bottom Sheet content
class LanguageBottomSheetContent extends StatefulWidget {
  final bool isDark;

  const LanguageBottomSheetContent({
    super.key,
    required this.isDark,
  });

  @override
  State<LanguageBottomSheetContent> createState() => _LanguageBottomSheetContentState();
}

class _LanguageBottomSheetContentState extends State<LanguageBottomSheetContent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'chooseLanguage',
            style: AppTextStyle.dmSans(
              fontSize: 18.0,
              weight: FontWeight.bold,
              color: widget.isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            ),
          ).tr(),
          ListTile(
            leading: Text('🇺🇸', style: TextStyle(fontSize: 24)),
            title: Text('english').tr(),
            onTap: () async {
              await context.setLocale(const Locale('en', 'US'));
              Navigator.pop(context);
              setState(() {});
            },
          ),
          ListTile(
            leading: Text('🇪🇸', style: TextStyle(fontSize: 24)),
            title: Text('spanish').tr(),
            onTap: () async {
              await context.setLocale(const Locale('es', 'ES'));
              Navigator.pop(context);
              setState(() {});
            },
          ),
          // Add more languages as needed
        ],
      ),
    );
  }
}