import 'package:flutter/cupertino.dart';
import 'package:job_contracts/presentation/features/users/profile/widgets/work_history_list.dart';

class EducationList extends StatelessWidget {
  final bool isDark;

  const EducationList({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WorkHistoryItem(
          period: '2002-Now',
          description: 'General Construction Firms',
          isDark: isDark,
        ),
      ],
    );
  }
}
