import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/proposal_and_offer/widgets/proposal-item.dart';

import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/circular_avatar.dart';
import '../../../../utils/common_widgets/main_button.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../routes/app_routes.dart';

class ProposalsOffersScreen extends StatefulWidget {
  const ProposalsOffersScreen({super.key});

  @override
  State<ProposalsOffersScreen> createState() => _ProposalsOffersScreenState();
}

class _ProposalsOffersScreenState extends State<ProposalsOffersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      appBar: JAppbar(
        leadingIcon: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_back,
              color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
            ),
          ),
        ),
        title: Text(
          'Proposals & Offers',
          style: AppTextStyle.dmSans(
            fontSize: 18.0,
            weight: FontWeight.w600,
            color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircularAvatar(
              isDark: isDark,
              radius: 18,
              imageUrl: JImages.image,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          // Page Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Proposals & Offers',
              style: AppTextStyle.dmSans(
                fontSize: 20.0,
                weight: FontWeight.w700,
                color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Tab Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isDark
                        ? JAppColors.darkGray700
                        : Colors.grey[300]!,
                    width: 1,
                  ),
                ),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: JAppColors.primary,
                unselectedLabelColor: isDark
                    ? JAppColors.darkGray100
                    : JAppColors.darkGray800,
                labelStyle: AppTextStyle.dmSans(
                  fontSize: 14.0,
                  weight: FontWeight.w600,
                  color: isDark
                      ? JAppColors.darkGray100
                      : JAppColors.lightGray800,
                ),
                unselectedLabelStyle: AppTextStyle.dmSans(
                  fontSize: 14.0,
                  weight: FontWeight.w500,
                  color: isDark
                      ? JAppColors.darkGray100
                      : JAppColors.lightGray800,
                ),
                indicatorColor: JAppColors.primary,
                indicatorWeight: 2.5,
                tabs: const [
                  Tab(text: 'Received Offers'),
                  Tab(text: 'Sent Proposals'),
                ],
              ),
            ),
          ),

          // Tab View Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Received Offers Tab
                _buildProposalsList(isDark, isReceivedOffers: true),

                // Sent Proposals Tab
                _buildProposalsList(isDark, isReceivedOffers: false),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildProposalsList(bool isDark, {required bool isReceivedOffers}) {
    // Sample data - replace with actual API data
    final proposals = List.generate(
      6,
          (index) => {
        'date': isReceivedOffers
            ? 'Received on 13 May 2024'
            : 'Sent on 10 May 2024',
        'title': 'Architects Construction for New Building',
        'timeAgo': '${index + 1} hours ago',
        'id': isReceivedOffers
            ? 'offer_${index + 1}'
            : 'proposal_${index + 1}', // Unique IDs for routing
      },
    );

    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: proposals.length,
      separatorBuilder: (context, index) => Divider(
        height: 32,
        color: isDark ? JAppColors.darkGray700 : Colors.grey[300],
      ),
      itemBuilder: (context, index) {
        final proposal = proposals[index];
        return ProposalItem(
          isDark: isDark,
          date: proposal['date']!,
          title: proposal['title']!,
          timeAgo: proposal['timeAgo']!,
          onTap: () {
            // ✅ Go to Proposal/Offer Details via AppRouter
            if (isReceivedOffers) {
              // For received offers (to apply)
              AppRouter.router.push(
                '/proposalOfferDetail',
                extra: {
                  'isReceivedOffer': true,
                  'proposalId': proposal['id'],
                },
              );
            } else {
              // For sent proposals (to view submission)
              AppRouter.router.push(
                '/proposalOfferDetail',
                extra: {
                  'isReceivedOffer': false,
                  'proposalId': proposal['id'],
                },
              );
            }
          },
        );
      },
    );
  }

  // Widget _buildProposalsList(bool isDark, {required bool isReceivedOffers}) {
  //   // Sample data - replace with actual API data
  //   final proposals = List.generate(
  //     6,
  //         (index) => {
  //       'date': isReceivedOffers
  //           ? 'Received on 13 May 2024'
  //           : 'Sent on 10 May 2024',
  //       'title': 'Architects Construction for New Building',
  //       'timeAgo': '${index + 1} hours ago',
  //     },
  //   );
  //
  //   return ListView.separated(
  //     padding: const EdgeInsets.all(16.0),
  //     itemCount: proposals.length,
  //     separatorBuilder: (context, index) => Divider(
  //       height: 32,
  //       color: isDark ? JAppColors.darkGray700 : Colors.grey[300],
  //     ),
  //     itemBuilder: (context, index) {
  //       final proposal = proposals[index];
  //       return ProposalItem(
  //         isDark: isDark,
  //         date: proposal['date']!,
  //         title: proposal['title']!,
  //         timeAgo: proposal['timeAgo']!,
  //         onTap: () {
  //
  //           // Navigate to proposal details screen
  //         },
  //       );
  //     },
  //   );
  // }
}
