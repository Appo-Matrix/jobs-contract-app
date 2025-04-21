import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/colors.dart';

/// A customizable dot progress indicator widget for showing loading states
class DotProgressIndicator extends StatefulWidget {
  final int dotCount;
  final double dotSize;
  final double spacing;
  final Duration animationDuration;
  final Color activeColor;
  final Color inactiveColor;

  const DotProgressIndicator({
    super.key,
    this.dotCount = 3,
    this.dotSize = 10.0,
    this.spacing = 8.0,
    this.animationDuration = const Duration(milliseconds: 300),
    this.activeColor = JAppColors.primary,
    this.inactiveColor = Colors.grey,
  });

  @override
  State<DotProgressIndicator> createState() => _DotProgressIndicatorState();
}

class _DotProgressIndicatorState extends State<DotProgressIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _currentDot = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _currentDot = (_currentDot + 1) % widget.dotCount;
        });
        _controller.reset();
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.dotCount,
            (index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.spacing / 2),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: widget.dotSize,
            height: widget.dotSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentDot == index
                  ? widget.activeColor
                  : widget.inactiveColor.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }
}

/// Shows a dot progress indicator dialog
void showDotProgressDialog({
  required BuildContext context,
  Color? backgroundColor,
  String? message,
  TextStyle? messageStyle,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.2),
    builder: (_) => Dialog(
      backgroundColor: backgroundColor ??
          (isDark ? JAppColors.backGroundDarkCard : Colors.white),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const DotProgressIndicator(
              dotCount: 3,
              dotSize: 12,
              spacing: 8,
              animationDuration: Duration(milliseconds: 350),
              activeColor: JAppColors.primary,
            ),
            if (message != null) ...[
              const SizedBox(height: 16),
              Text(
                message,
                style: messageStyle ?? TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    ),
  );
}

// Example usage:
void showLoadingDialog(BuildContext context) {
  showDotProgressDialog(
    context: context,
    message: "Please wait...",
  );

  // To dismiss:
  // Navigator.of(context).pop();
}