import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/finanance_report/widgets/payment_method_card.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/back_circle.dart';

class WithdrawalScreen extends StatefulWidget {
  const WithdrawalScreen({super.key});

  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  double availableBalance = 700.00;
  int? selectedMethodIndex;
  bool withdrawalCompleted = false;

  final List<Map<String, dynamic>> withdrawalMethods = [
    {'type': 'visa', 'number': 'HBL-430943XXX', 'label': 'Shehla-Primary'},
    {
      'type': 'mastercard',
      'number': 'BAH-430943XXX',
      'label': 'Shehla-Primary'
    },
    {
      'type': 'mastercard',
      'number': 'HBL-430943XXX',
      'label': 'Shehla-Secondary'
    },
    {'type': 'mastercard', 'number': 'BAH-430943XXX', 'label': 'Shehla-Other'},
  ];

  void handleWithdrawal() {
    setState(() {
      withdrawalCompleted = true;
    });
  }

  void navigateToHome() {
    // Navigate back to home
    AppRouter.router.push('/navigationMenu');
  }

  void handleMethodSelection(int index) {
    setState(() {
      selectedMethodIndex = index;
    });
  }

  void showMethodOptions(bool isDark) {
    // Show options menu for payment method
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: Text(
                JText.editDetails,
                style: AppTextStyle.dmSans(
                  color:
                      isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  fontSize: 16.0,
                  weight: FontWeight.w400,
                ),
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(
                Icons.delete_outline,
              ),
              title: Text(
                JText.removeMethod,
                style: AppTextStyle.dmSans(
                  color:
                      isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  fontSize: 16.0,
                  weight: FontWeight.w400,
                ),
              ),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      appBar: JAppbar(
        title: Text(
          withdrawalCompleted ? '' : JText.withdraw,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            fontSize: 19.0,
            weight: FontWeight.w500,
          ),
        ),
        leadingIcon: !withdrawalCompleted
            ? Padding(
                padding: const EdgeInsets.all(2.0),
                child: BackCircle(
                  isDark: isDark,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              )
            : null,
      ),
      body: withdrawalCompleted
          ? _buildSuccessScreen(isDark)
          : _buildWithdrawalScreen(isDark),
    );
  }

  Widget _buildWithdrawalScreen(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          // Available Balance
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                JText.availableBalances,
                style: AppTextStyle.dmSans(
                  color:
                      isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  fontSize: 16.0,
                  weight: FontWeight.w500,
                ),
              ),
              AmountText(amount: availableBalance),
            ],
          ),

          const SizedBox(height: 32),

          // Withdrawal Method Title
          Text(
            JText.selectWithdrawalMethod,
            style: AppTextStyle.dmSans(
              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
              fontSize: 16.0,
              weight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 16),

          // Withdrawal Methods List
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: withdrawalMethods.length,
              itemBuilder: (context, index) {
                final method = withdrawalMethods[index];
                return PaymentMethodCard(
                  type: method['type'],
                  number: method['number'],
                  label: method['label'],
                  isSelected: selectedMethodIndex == index,
                  onTap: () => handleMethodSelection(index),
                  onMoreTap: () => showMethodOptions(isDark),
                );
              },
            ),
          ),

          // Withdraw Button
          WithdrawalButton(
            onPressed: selectedMethodIndex != null ? handleWithdrawal : null,
            text: JText.withdrawButton,
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessScreen(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Success Icon
          const SuccessIcon(),

          const SizedBox(height: 16),

          // Success Message
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AmountText(
                amount: availableBalance,
                fontSize: 20.0,
              ),
              Text(
                " ${JText.withdrawalCompleted}",
                style: AppTextStyle.dmSans(
                  color:
                      isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  fontSize: 20.0,
                  weight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            JText.successMessage,
            style: AppTextStyle.dmSans(
              color: Colors.grey.shade600,
              fontSize: 14.0,
              weight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 40),

          // Back to Home Button
          WithdrawalButton(
            onPressed: navigateToHome,
            text: JText.backToHome,
          ),
        ],
      ),
    );
  }
}
