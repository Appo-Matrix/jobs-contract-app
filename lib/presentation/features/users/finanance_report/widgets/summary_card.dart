import 'package:flutter/material.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../model/transcations.dart';
import 'filter_chip.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String amount;
  final String percentage;
  final bool isPositive;
  final bool isDark;

  const SummaryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.percentage,
    required this.isPositive,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color: isDark ? JAppColors.backGroundDarkCard : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: JAppColors.lightGray500),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyle.dmSans(
                color:
                    isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
                fontSize: 14.0,
                weight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  amount,
                  style: AppTextStyle.dmSans(
                    color:
                        isDark
                            ? JAppColors.darkGray100
                            : JAppColors.lightGray900,
                    fontSize: 24.0,
                    weight: FontWeight.w700,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isPositive
                            ? (isDark
                                ? Colors.green[900]!.withOpacity(0.3)
                                : Colors.green[50])
                            : (isDark
                                ? Colors.red[900]!.withOpacity(0.3)
                                : Colors.red[50]),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                        size: 14,
                        color:
                            isPositive
                                ? (isDark ? Colors.green[200]! : Colors.green)
                                : (isDark ? Colors.red[200]! : Colors.red),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        percentage,
                        style: AppTextStyle.dmSans(
                          color:
                              isPositive
                                  ? (isDark ? Colors.green[200]! : Colors.green)
                                  : (isDark ? Colors.red[200]! : Colors.red),
                          fontSize: 13.0,
                          weight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class SelectPeriodButton extends StatelessWidget {
  final bool isDark;
  final VoidCallback? onTap;

  const SelectPeriodButton({super.key, required this.isDark, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isDark ? JAppColors.darkGray700 : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark ? JAppColors.darkGray600 : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 16,
              color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
            ),
            const SizedBox(width: 8),
            Text(
              JText.selectPeriod,
              style: AppTextStyle.dmSans(
                color:
                    isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
                fontSize: 14.0,
                weight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionTableHeader extends StatelessWidget {
  final bool isDark;

  const TransactionTableHeader({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            JText.method,
            style: AppTextStyle.dmSans(
              color:
                  isDark
                      ? JAppColors.darkGray300
                      : JAppColors.lightGray600,
              fontSize: 14.0,
              weight: FontWeight.w500,
            ),
          ),
          Text(
            JText.date,
            style: AppTextStyle.dmSans(
              color:
                  isDark
                      ? JAppColors.darkGray300
                      : JAppColors.lightGray600,
              fontSize: 14.0,
              weight: FontWeight.w500,
            ),
          ),
          Text(
            JText.amount,
            style: AppTextStyle.dmSans(
              color:
                  isDark
                      ? JAppColors.darkGray300
                      : JAppColors.lightGray600,
              fontSize: 14.0,
              weight: FontWeight.w500,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}

/// Widget for individual transaction rows
class TransactionRow extends StatelessWidget {
  final Transaction transaction;
  final bool isDark;
  final VoidCallback? onOptionsTap;

  const TransactionRow({
    super.key,
    required this.transaction,
    required this.isDark,
    this.onOptionsTap,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = transaction.isPositive;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark ? JAppColors.darkGray700 : Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              transaction.method,
              style: AppTextStyle.dmSans(
                color:
                    isDark ? JAppColors.darkGray200 : JAppColors.lightGray800,
                fontSize: 14.0,
                weight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              transaction.date,
              style: AppTextStyle.dmSans(
                color:
                    isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
                fontSize: 14.0,
                weight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '\$${transaction.amount}',
              style: AppTextStyle.dmSans(
                color:
                    isPositive
                        ? (isDark ? Colors.green[300]! : Colors.green[700]!)
                        : (isDark ? Colors.red[300]! : Colors.red[700]!),
                fontSize: 14.0,
                weight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(
            width: 40,
            child: IconButton(
              icon: Icon(
                Icons.more_vert,
                color:
                    isDark ? JAppColors.darkGray400 : JAppColors.lightGray500,
                size: 20,
              ),
              onPressed: onOptionsTap,
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget for the transactions list section
class TransactionsListSection extends StatelessWidget {
  final bool isDark;
  final List<Transaction> transactions;
  final String selectedFilter;
  final Function(String) onFilterChanged;
  final VoidCallback onSelectPeriod;

  const TransactionsListSection({
    super.key,
    required this.isDark,
    required this.transactions,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.onSelectPeriod,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            JText.lastTransactions,
            style: AppTextStyle.dmSans(
              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
              fontSize: 18.0,
              weight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            JText.checkTransactions,
            style: AppTextStyle.dmSans(
              color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
              fontSize: 14.0,
              weight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),

          // Period Filter
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FilterChips(
                  label: JText.thisMonth,
                  isSelected: selectedFilter == JText.thisMonth,
                  isDark: isDark,
                  onTap: () => onFilterChanged(JText.thisMonth),
                ),
                const SizedBox(width: 8),
                FilterChips(
                  label: JText.lastMonth,
                  isSelected: selectedFilter == JText.lastMonth,
                  isDark: isDark,
                  onTap: () => onFilterChanged(JText.lastMonth),
                ),
                const SizedBox(width: 8),
                FilterChips(
                  label: JText.last12Months,
                  isSelected: selectedFilter == JText.last12Months,
                  isDark: isDark,
                  onTap: () => onFilterChanged(JText.last12Months),
                ),
                const SizedBox(width: 16),
                SelectPeriodButton(isDark: isDark, onTap: onSelectPeriod),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Transactions Table Header
          TransactionTableHeader(isDark: isDark,)
          ,
          // Transactions List
          ...transactions.map(
            (transaction) => TransactionRow(
              transaction: transaction,
              isDark: isDark,
              onOptionsTap: () {
                // Show transaction options
              },
            ),
          ),
        ],
      ),
    );
  }
}
