import 'package:flutter/material.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/device/device_utility.dart';
import '../widgets/proposal_card.dart';

class ActiveProposalsScreen extends StatelessWidget {
  const ActiveProposalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = JDeviceUtils.isDarkMode(context);
    final List<Map<String, dynamic>> proposals = _getMockProposals();

    if (proposals.isEmpty) {
      return _buildEmptyState(isDark);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: proposals.length,
      itemBuilder: (context, index) {
        final proposal = proposals[index];
        return ProposalCard(
          isDark: isDark,
          jobTitle: proposal['jobTitle'],
          salary: proposal['salary'],
          category: proposal['category'],
          jobType: proposal['jobType'],
          duration: proposal['duration'],
          description: proposal['description'],
          employerName: proposal['employerName'],
          location: proposal['location'],
          postedTime: proposal['postedTime'],
          isVerified: proposal['isVerified'],
          employerImage: proposal['employerImage'],
          onProposalTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Viewing proposal for ${proposal['jobTitle']}')),
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.work_outline, size: 64, color: isDark ? Colors.white38 : Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'No active proposals yet',
            style: AppTextStyle.dmSans(
              fontSize: 16,
              weight: FontWeight.w500,
              color: isDark ? Colors.white70 : JAppColors.lightGray900,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getMockProposals() {
    return [
      {
        'jobTitle': 'Senior Plumber Needed',
        'salary': '\$55,000 - \$65,000',
        'category': 'Plumbing',
        'jobType': 'Onsite',
        'duration': '6 Months',
        'description': 'Experienced plumber needed...',
        'employerName': 'Robert Johnson',
        'location': 'New York, USA',
        'postedTime': '2 days ago',
        'isVerified': true,
        'employerImage': null,
      },
      {
        'jobTitle': 'Electrical Engineer',
        'salary': '\$70,000 - \$85,000',
        'category': 'Electrical',
        'jobType': 'Remote',
        'duration': '12 Months',
        'description': 'We need a skilled electrical engineer...',
        'employerName': 'Emily Clark',
        'location': 'Chicago, USA',
        'postedTime': '5 days ago',
        'isVerified': true,
        'employerImage': null,
      },
    ];
  }
}
