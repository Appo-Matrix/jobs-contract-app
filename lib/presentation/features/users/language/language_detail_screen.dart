import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/circular_shape.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';

class LanguageDetailScreen extends StatefulWidget {


  const LanguageDetailScreen({
    super.key,
  });

  @override
  State<LanguageDetailScreen> createState() => _LanguageDetailScreenState();
}

class _LanguageDetailScreenState extends State<LanguageDetailScreen> {
  late bool isFirstLanguage;
  int oralLevel = 10;
  String oralLevelText = 'Level 10';
  int writtenLevel = 0;
  String writtenLevelText = 'Choose your speaking skill level';


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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

    ]
    ));
  }

  void showLevelSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      return RadioListTile(
                        title: Text('Level $index'),
                        value: index,
                        groupValue: writtenLevel,
                        activeColor: Colors.purple,
                        onChanged: (value) {
                          setState(() {
                            writtenLevel = value!;
                          });

                          // Update parent state
                          this.setState(() {
                            if (value == 0) {
                              writtenLevelText = 'Choose your speaking skill level';
                            } else {
                              writtenLevelText = 'Level $value';
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class Language {
  final String name;
  final String flag;

  Language({required this.name, required this.flag});
}