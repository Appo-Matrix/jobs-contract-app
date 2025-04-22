import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/device/device_utility.dart';

class PaymentMethodCard extends StatelessWidget {
  final String type; // 'visa' or 'mastercard'
  final String number;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onMoreTap;

  const PaymentMethodCard({
    super.key,
    required this.type,
    required this.number,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? JAppColors.backGroundDarkCard : JAppColors.lightGray100,
        border: Border.all(
          color: isSelected ? const Color(0xFF8B5CF6) : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: type == 'visa'
            ? Image.asset(JImages.card, width: 50)
            : Image.asset(JImages.card, width: 50),
        title: Text(
          number,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            fontSize: 14.0,
            weight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          label,
          style: AppTextStyle.dmSans(
            color: Colors.grey.shade600,
            fontSize: 12.0,
            weight: FontWeight.w400,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: onMoreTap,
        ),
      ),
    );
  }
}

class WithdrawalButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const WithdrawalButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 24),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8B5CF6), // Purple color
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          disabledBackgroundColor: const Color(0xFF8B5CF6).withOpacity(0.5),
        ),
        child: Text(
          text,
          style: AppTextStyle.dmSans(
            color: Colors.white,
            fontSize: 16.0,
            weight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class SuccessIcon extends StatelessWidget {
  const SuccessIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFF86DC60), // Green color
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(
        Icons.check,
        color: Colors.white,
        size: 40,
      ),
    );
  }
}

class AmountText extends StatelessWidget {
  final double amount;
  final bool highlight;
  final double fontSize;

  const AmountText({
    super.key,
    required this.amount,
    this.highlight = true,
    this.fontSize = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '\$${amount.toStringAsFixed(0)}',
      style: AppTextStyle.dmSans(
        color: highlight ? const Color(0xFF8B5CF6) : JDeviceUtils.isDarkMode(context)
            ? JAppColors.darkGray100
            : JAppColors.lightGray900,
        fontSize: fontSize,
        weight: FontWeight.w700,
      ),
    );
  }
}