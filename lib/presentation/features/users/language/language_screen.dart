import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/back_circle.dart';
import '../../../../utils/common_widgets/main_button.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  // List of user's languages
  final List<Language> _userLanguages = [
    Language(name: "French", flagCode: "fr", proficiencyLevel: "Fluent"),
    Language(name: "English", flagCode: "gb", proficiencyLevel: "Basic"),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
      appBar: JAppbar(
        title: Text(
          "Language",
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            fontSize: 20.0,
            weight: FontWeight.w600,
          ),
        ),
        leadingIcon: BackCircle(
          isDark: isDark,
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User's languages list
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ..._userLanguages.map((language) => _buildLanguageCard(language, isDark)),
                ],
              ),
            ),
          ),

          // Add language button at the bottom
          Padding(
            padding: const EdgeInsets.all(16),
            child: MainButton(
              btn_title: "Add Another Language",
              btn_radius: 10,
              btn_color: JAppColors.primary,
              btn_boarder_color: JAppColors.primary,
              title_color: Colors.white,
              text_fontweight: FontWeight.w600,
              image_value: false,
              onTap: () {
                // Show language selection dialog/screen
                _showAddLanguageBottomSheet(context, isDark);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageCard(Language language, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? JAppColors.darkGray800 : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark ? JAppColors.darkGray600 : JAppColors.lightGray300,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/flags/${language.flagCode}.png'),
          radius: 18,
        ),
        title: Text(
          language.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            language.proficiencyLevel,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
            ),
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete_outline,
            color: Colors.red[400],
          ),
          onPressed: () {
            _showDeleteConfirmationDialog(context, language, isDark);
          },
        ),
        onTap: () {
          // Show language proficiency selection
          _showProficiencyBottomSheet(context, language, isDark);
        },
      ),
    );
  }

  void _showAddLanguageBottomSheet(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: isDark ? JAppColors.darkGray700 : Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              children: [
                // Handle bar
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(top: 12, bottom: 24),
                  decoration: BoxDecoration(
                    color: isDark ? JAppColors.darkGray500 : JAppColors.lightGray400,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark ? JAppColors.lightGray500 : Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isDark ? JAppColors.darkGray600 : JAppColors.lightGray300,
                        width: 1.0,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          JImages.search,
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: JText.searchJob,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintStyle: AppTextStyle.dmSans(
                                fontSize: JSizes.fontSizeMd,
                                weight: FontWeight.w400,
                                color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray500,
                              ),
                            ),
                            style: AppTextStyle.dmSans(
                              fontSize: JSizes.fontSizeMd,
                              weight: FontWeight.w400,
                              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                // Language list
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    children: [
                      _buildLanguageOption("Arabic", "sa", isDark),
                      _buildLanguageOption("English", "gb", isDark),
                      _buildLanguageOption("Indonesian", "id", isDark),
                      _buildLanguageOption("Malaysian", "my", isDark),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLanguageOption(String name, String flagCode, bool isDark) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/flags/$flagCode.png'),
        radius: 16,
      ),
      title: Text(
        name,
        style: AppTextStyle.dmSans(
          color: isDark ? Colors.white : Colors.black,
          fontSize: 16.0,
          weight: FontWeight.w500,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        // Create a new language and show proficiency selection
        final newLanguage = Language(
          name: name,
          flagCode: flagCode,
          proficiencyLevel: "Basic", // Default
        );
        _showProficiencyBottomSheet(context, newLanguage, isDark, isNew: true);
      },
    );
  }

  void _showProficiencyBottomSheet(BuildContext context, Language language, bool isDark, {bool isNew = false}) {
    String selectedProficiency = language.proficiencyLevel.isEmpty ? "Basic" : language.proficiencyLevel;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
            builder: (context, setModalState) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? JAppColors.darkGray700 : Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 24),
                      decoration: BoxDecoration(
                        color: isDark ? JAppColors.darkGray500 : JAppColors.lightGray400,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),

                    // Proficiency options
                    _buildProficiencyOption("Basic", selectedProficiency, isDark, (level) {
                      setModalState(() => selectedProficiency = level);
                    }),
                    const SizedBox(height: 16),
                    _buildProficiencyOption("Conversational", selectedProficiency, isDark, (level) {
                      setModalState(() => selectedProficiency = level);
                    }),
                    const SizedBox(height: 16),
                    _buildProficiencyOption("Fluent", selectedProficiency, isDark, (level) {
                      setModalState(() => selectedProficiency = level);
                    }),
                    const SizedBox(height: 24),

                    // Done button
                    MainButton(
                      btn_title: "Done",
                      btn_radius: 10,
                      btn_color: JAppColors.primary,
                      btn_boarder_color: JAppColors.primary,
                      title_color: Colors.white,
                      text_fontweight: FontWeight.w600,
                      image_value: false,
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          if (isNew) {
                            // Add new language
                            language.proficiencyLevel = selectedProficiency;
                            _userLanguages.add(language);
                          } else {
                            // Update existing language
                            final index = _userLanguages.indexWhere((l) => l.name == language.name);
                            if (index >= 0) {
                              _userLanguages[index].proficiencyLevel = selectedProficiency;
                            }
                          }
                        });
                      },
                    ),
                  ],
                ),
              );
            }
        );
      },
    );
  }

  Widget _buildProficiencyOption(String level, String selectedLevel, bool isDark, Function(String) onTap) {
    final isSelected = selectedLevel == level;

    return InkWell(
      onTap: () => onTap(level),
      child: Row(
        children: [
          Text(
            level,
            style: AppTextStyle.dmSans(
              color: isDark ? Colors.white : Colors.black,
              fontSize: 16.0,
              weight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? JAppColors.primary : (isDark ? JAppColors.darkGray400 : JAppColors.lightGray500),
                width: 2,
              ),
            ),
            child: isSelected
                ? Center(
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: JAppColors.primary,
                ),
              ),
            )
                : null,
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Language language, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? JAppColors.darkGray700 : Colors.white,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: isDark ? JAppColors.darkGray500 : JAppColors.lightGray400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              Text(
                "Remove ${language.name}?",
                style: AppTextStyle.dmSans(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 18.0,
                  weight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),

              Text(
                "Are you sure you want to delete this ${language.name} language?",
                textAlign: TextAlign.center,
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.darkGray200 : JAppColors.lightGray700,
                  fontSize: 14.0,
                  weight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 24),

              // Continue button
              MainButton(
                btn_title: "Continue Filling",
                btn_radius: 10,
                btn_color: JAppColors.primary,
                btn_boarder_color: JAppColors.primary,
                title_color: Colors.white,
                text_fontweight: FontWeight.w600,
                image_value: false,
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _userLanguages.removeWhere((item) => item.name == language.name);
                  });
                },
              ),

              const SizedBox(height: 12),

              // Undo button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Undo Changes",
                    style: AppTextStyle.dmSans(
                      fontSize: 16.0,
                      weight: FontWeight.w600, color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Language {
  final String name;
  final String flagCode;
  String proficiencyLevel;

  Language({
    required this.name,
    required this.flagCode,
    required this.proficiencyLevel,
  });
}