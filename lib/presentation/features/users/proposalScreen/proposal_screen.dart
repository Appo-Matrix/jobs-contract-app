import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/proposalScreen/tab_screen/active_proposals_screen.dart';
import 'package:job_contracts/presentation/features/users/proposalScreen/tab_screen/closed_proposals_screen.dart';
import 'package:job_contracts/presentation/features/users/proposalScreen/tab_screen/view_proposals_screen.dart';
import 'package:job_contracts/presentation/features/users/proposalScreen/widgets/proposal_card.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/back_circle.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class ProposalScreen extends StatefulWidget {
  const ProposalScreen({super.key});

  @override
  State<ProposalScreen> createState() => _ProposalScreenState();
}

class _ProposalScreenState extends State<ProposalScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['Active', 'Pending', 'Closed'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = JDeviceUtils.isDarkMode(context);
    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      appBar: JAppbar(
        leadingIcon: Padding(
          padding: const EdgeInsets.all(3.0),
          child: BackCircle(
            isDark: isDark,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          JText.proposal,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            fontSize: 19.0,
            weight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          // Tab Bar
          SizedBox(
            height: 35,
            child: TabBar(
              dividerColor: Colors.transparent,
              controller: _tabController,
              // Set the controller
              // Add rounded indicator with no underline
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: JAppColors.primary,
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              // Set selected tab text color to white
              unselectedLabelColor:
              isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
              padding: EdgeInsets.all(3),
              indicatorWeight: 0,
              // Set to 0 to remove the underline
              labelStyle: AppTextStyle.dmSans(
                fontSize: JSizes.fontSizeESm,
                weight: FontWeight.w500,
                color: Colors.white,
              ),
              unselectedLabelStyle: AppTextStyle.dmSans(
                fontSize: JSizes.fontSizeESm,
                weight: FontWeight.w500,
                color: Colors.white,
              ),
              tabs: [
                Tab(text: JText.active),
                Tab(text: JText.view),
                Tab(text: JText.closed),
              ],
            ),
          ),


          // Tab View Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ActiveProposalsScreen(),
                ViewProposalsScreen(),

                ClosedProposalsScreen(),

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProposalList(bool isDark, String status) {
    // This would be replaced with actual data from an API or state management
    final List<Map<String, dynamic>> mockProposals = _getMockProposals(status);

    if (mockProposals.isEmpty) {
      return _buildEmptyState(isDark, status);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: mockProposals.length,
      itemBuilder: (context, index) {
        final proposal = mockProposals[index];
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
          onProposalTap: () => _onProposalTap(context, proposal),
        );
      },
    );
  }

  void _onProposalTap(BuildContext context, Map<String, dynamic> proposal) {
    // Navigate to proposal details page
    // Navigator.push(context, MaterialPageRoute(builder: (context) => ProposalDetailsScreen(proposal: proposal)));

    // For now, just show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Viewing proposal for ${proposal['jobTitle']}')),
    );
  }

  Widget _buildEmptyState(bool isDark, String status) {
    String message;
    IconData icon;

    switch (status) {
      case 'active':
        message = 'No active proposals yet';
        icon = Icons.work_outline;
        break;
      case 'pending':
        message = 'No pending proposals';
        icon = Icons.hourglass_empty;
        break;
      case 'closed':
        message = 'No closed proposals';
        icon = Icons.check_circle_outline;
        break;
      default:
        message = 'No proposals found';
        icon = Icons.info_outline;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: isDark ? Colors.white38 : Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: AppTextStyle.dmSans(
              fontSize: 16.0,
              weight: FontWeight.w500,
              color: isDark ? Colors.white70 : JAppColors.lightGray900,
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
              // Navigate to job browsing screen
            },
            child: Text(
              'Browse Jobs',
              style: AppTextStyle.dmSans(
                fontSize: 16,
                weight: FontWeight.w600,
                color: JAppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getMockProposals(String status) {
    // This would be replaced with actual data from a repository or API
    if (status == 'active') {
      return [
        {
          'jobTitle': 'Senior Plumber Needed',
          'salary': '\$55,000 - \$65,000',
          'category': 'Plumbing',
          'jobType': 'Onsite',
          'duration': '6 Months',
          'description': 'We are looking for an experienced plumber to join our team for a major commercial project. Must have at least 5 years of experience with commercial plumbing systems and be able to work independently.',
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
          'description': 'We need a skilled electrical engineer to oversee the design and implementation of electrical systems for our new high-rise building project. Must be familiar with current electrical codes and safety standards.',
          'employerName': 'Emily Clark',
          'location': 'Chicago, USA',
          'postedTime': '5 days ago',
          'isVerified': true,
          'employerImage': null,
        },
      ];
    } else if (status == 'pending') {
      return [
        {
          'jobTitle': 'Construction Manager',
          'salary': '\$85,000 - \$95,000',
          'category': 'Management',
          'jobType': 'Hybrid',
          'duration': '24 Months',
          'description': 'Seeking an experienced construction manager to oversee our new residential development project. Responsibilities include team management, budget control, and ensuring compliance with safety regulations.',
          'employerName': 'Development Partners LLC',
          'location': 'Austin, USA',
          'postedTime': '1 week ago',
          'isVerified': false,
          'employerImage': null,
        },
      ];
    } else if (status == 'closed') {
      return [
        {
          'jobTitle': 'HVAC Technician',
          'salary': '\$45,000 - \$55,000',
          'category': 'HVAC',
          'jobType': 'Onsite',
          'duration': '3 Months',
          'description': 'We were looking for an HVAC technician for a short-term project involving installation and maintenance of commercial air conditioning systems. This position has been filled.',
          'employerName': 'Cool Systems Inc.',
          'location': 'Miami, USA',
          'postedTime': '3 weeks ago',
          'isVerified': true,
          'employerImage': null,
        },
        {
          'jobTitle': 'Interior Designer',
          'salary': '\$60,000 - \$70,000',
          'category': 'Design',
          'jobType': 'Remote',
          'duration': '6 Months',
          'description': 'We needed a creative interior designer to work on luxury apartment designs. This position has been filled.',
          'employerName': 'Luxury Living Spaces',
          'location': 'Los Angeles, USA',
          'postedTime': '1 month ago',
          'isVerified': true,
          'employerImage': null,
        },
      ];
    }
    return [];
  }
}