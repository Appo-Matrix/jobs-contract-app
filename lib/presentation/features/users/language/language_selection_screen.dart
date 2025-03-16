import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';

import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/circular_shape.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});


  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? selectedLanguage;
  List<Language> filteredLanguages = [];

  final List<Language> languages = [
    Language(name: 'Arabic', flag: 'assets/flags/arabic.png'),
    Language(name: 'Indonesian', flag: 'assets/flags/indonesian.png'),
    Language(name: 'Malaysian', flag: 'assets/flags/malaysian.png'),
    Language(name: 'English', flag: 'assets/flags/english.png'),
    Language(name: 'French', flag: 'assets/flags/french.png'),
    Language(name: 'German', flag: 'assets/flags/german.png'),
    Language(name: 'Hindi', flag: 'assets/flags/hindi.png'),
    Language(name: 'Italian', flag: 'assets/flags/italian.png'),
    Language(name: 'Japanese', flag: 'assets/flags/japanese.png'),
  ];

  @override
  void initState() {
    super.initState();
    filteredLanguages = languages;
    _searchController.addListener(_filterLanguages);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterLanguages() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredLanguages = languages
          .where((language) => language.name.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,

      appBar: JAppbar(
        title: Text(
          JText.language,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            fontSize: 20.0,
            weight: FontWeight.w600,
          ),
        ),
        leadingIcon: GestureDetector(
          onTap: (){

            Navigator.pop(context);

          },
          child: JCircularAvatar(
            isDark: isDark,
            radius: 20, // Modify the radius to make it larger
            child: Icon(
              CupertinoIcons.back,
              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey.shade600),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search Language',
                        border: InputBorder.none,
                        enabledBorder:  InputBorder.none,
                        focusedBorder:  InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Divider
          Divider(height: 1, thickness: 1, color: Colors.grey.shade200),

          // Languages list
          Expanded(
            child: ListView.builder(
              itemCount: filteredLanguages.length,
              itemBuilder: (context, index) {
                final language = filteredLanguages[index];
                final isSelected = language.name == selectedLanguage;

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(language.flag),
                    ),
                    title: Text(
                      language.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: isSelected
                        ? const Icon(Icons.check, color: Colors.black)
                        : null,
                    onTap: () {
                      AppRouter.router.push('/languageDetailScreen');
                      setState(() {
                        selectedLanguage = language.name;
                      });

                      // You can add navigation here
                      // Navigator.push(context, MaterialPageRoute(builder: ...));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Language {
  final String name;
  final String flag;

  Language({required this.name, required this.flag});
}