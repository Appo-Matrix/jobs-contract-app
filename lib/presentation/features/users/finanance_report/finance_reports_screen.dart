import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/finanance_report/widgets/summary_card.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/back_circle.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../routes/app_routes.dart';
import 'model/transcations.dart';

class FinanceReportScreen extends StatefulWidget {
  const FinanceReportScreen({super.key});

  @override
  State<FinanceReportScreen> createState() => _FinanceReportScreenState();
}

class _FinanceReportScreenState extends State<FinanceReportScreen> {
  String selectedFilter = JText.thisMonth;

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    // Sample transaction data
    final List<Map<String, dynamic>> transactions = [
      {'method': 'Bank account', 'date': '2024/04/01', 'amount': '+750.00'},
      {'method': 'Credit card', 'date': '2024/03/29', 'amount': '-9.90'},
      {'method': 'Credit card', 'date': '2024/03/29', 'amount': '-19.90'},
      {'method': 'Bank account', 'date': '2024/03/27', 'amount': '+400.00'},
      {'method': 'Credit card', 'date': '2024/03/26', 'amount': '-64.33'},
      {'method': 'Credit card', 'date': '2024/03/26', 'amount': '-64.33'},
      {'method': 'Credit card', 'date': '2024/03/24', 'amount': '-147.90'},
      {'method': 'Credit card', 'date': '2024/03/24', 'amount': '-147.90'},
      {'method': 'Credit card', 'date': '2024/03/21', 'amount': '-57.98'},
      {'method': 'Credit card', 'date': '2024/03/21', 'amount': '-57.98'},
      {'method': 'Credit card', 'date': '2024/03/26', 'amount': '-64.33'},
      {'method': 'Credit card', 'date': '2024/03/24', 'amount': '-147.90'},
      {'method': 'Credit card', 'date': '2024/03/21', 'amount': '-57.98'},
    ];

    // Convert to Transaction objects
    final transactionList =
        transactions.map((t) => Transaction.fromMap(t)).toList();


    void handleFilterChange(String filter) {
      setState(() {
        selectedFilter = filter;
      });
    }

    void handleSelectPeriod() {
      print('Select Period tapped');
      // showDateRangePicker or your custom logic here
    }
    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      appBar: JAppbar(
        title: Text(
          JText.financeReport,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            fontSize: 19.0,
            weight: FontWeight.w500,
          ),
        ),
        // leadingIcon: Padding(
        //   padding: const EdgeInsets.all(2.0),
        //   child: BackCircle(
        //     isDark: isDark,
        //     onTap: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ),


        // actions: [
        //   Container(
        //     margin: const EdgeInsets.only(right: 16),
        //     height: 32,
        //     width: 100,
        //     child: ElevatedButton(
        //       onPressed: () {
        //         AppRouter.router.push('/withdrawalScreen');
        //       },
        //       style: ElevatedButton.styleFrom(
        //         backgroundColor: JAppColors.primary,
        //         foregroundColor: Colors.white,
        //         elevation: 0,
        //         padding: EdgeInsets.zero,
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(8),
        //         ),
        //       ),
        //       child: Text(
        //         JText.withdraw,
        //         style: AppTextStyle.dmSans(
        //           color: Colors.white,
        //           fontSize: 16.0,
        //           weight: FontWeight.w400,
        //         ),
        //       ),
        //     ),
        //   ),
        // ],



      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Cards
            SummaryCard(
              title: 'Balance',
              amount: '\$1,150.00',
              percentage: '12.3%',
              isPositive: true,
              isDark: isDark,
            ),
            SummaryCard(
              title: 'Total Spent',
              amount: '\$718.22',
              percentage: '5.2%',
              isPositive: false,
              isDark: isDark,
            ),



            TransactionsListSection(
              isDark: isDark,
              transactions: transactionList,
              selectedFilter: selectedFilter,
              onFilterChanged: handleFilterChange,
              onSelectPeriod: handleSelectPeriod,
            ),

          ],
        ),
      ),
    );
  }
}

