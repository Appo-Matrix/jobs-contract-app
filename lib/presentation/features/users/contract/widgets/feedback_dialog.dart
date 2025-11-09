import 'package:flutter/material.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';

class FeedbackDialog extends StatefulWidget {
  final bool isDark;

  const FeedbackDialog({
    super.key,
    required this.isDark,
  });

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  int _rating = 0;
  final Set<String> _selectedLikes = {};
  final Set<String> _selectedDislikes = {};
  final TextEditingController _reviewController = TextEditingController();

  final List<String> _likeOptions = [
    'Easy to use',
    'Complete',
    'helpful',
    'Looks good',
    'Convenient',
  ];

  final List<String> _dislikeOptions = [
    'Could have more components',
    'Complex',
    'Not interactive',
    'Only English',
  ];

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: widget.isDark ? JAppColors.darkGray800 : Colors.white,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Feedback',
                    style: AppTextStyle.dmSans(
                      fontSize: 20.0,
                      weight: FontWeight.w700,
                      color: widget.isDark
                          ? JAppColors.darkGray100
                          : JAppColors.lightGray900,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close,
                      color: widget.isDark
                          ? JAppColors.darkGray300
                          : JAppColors.lightGray700,
                    ),
                    iconSize: 20,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Finished message
              Text(
                'Your project is finished.',
                style: AppTextStyle.dmSans(
                  fontSize: 15.0,
                  weight: FontWeight.w400,
                  color: widget.isDark
                      ? JAppColors.darkGray100
                      : JAppColors.lightGray900,
                ),
              ),
              const SizedBox(height: 12),

              // Rating question
              Text(
                'How would you rate the Experience?',
                style: AppTextStyle.dmSans(
                  fontSize: 13.0,
                  color: widget.isDark
                      ? JAppColors.darkGray400
                      : JAppColors.lightGray600,
                  weight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 12),

              // Star Rating
              Row(
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                    child: Icon(
                      index < _rating ? Icons.star : Icons.star_border,
                      color: index < _rating
                          ? const Color(0xFFFFC107)
                          : widget.isDark
                          ? JAppColors.darkGray600
                          : JAppColors.lightGray400,
                      size: 32,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),

              // What did you like
              Text(
                'What did you like about it?',
                style: AppTextStyle.dmSans(
                  fontSize: 14.0,
                  weight: FontWeight.w500,
                  color: JAppColors.primary,
                ),
              ),
              const SizedBox(height: 12),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _likeOptions.map((option) {
                  final isSelected = _selectedLikes.contains(option);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedLikes.remove(option);
                        } else {
                          _selectedLikes.add(option);
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? JAppColors.primary.withOpacity(0.15)
                            : widget.isDark
                            ? JAppColors.darkGray700
                            : JAppColors.lightGray200,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected
                              ? JAppColors.primary
                              : widget.isDark
                              ? JAppColors.darkGray600
                              : JAppColors.lightGray300,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        option,
                        style: AppTextStyle.dmSans(
                          fontSize: 13.0,
                          color: isSelected
                              ? JAppColors.primary
                              : widget.isDark
                              ? JAppColors.darkGray300
                              : JAppColors.lightGray700,
                          weight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // How was your experience
              Text(
                'How was Your Experience?',
                style: AppTextStyle.dmSans(
                  fontSize: 14.0,
                  weight: FontWeight.w500,
                  color: JAppColors.primary,
                ),
              ),
              const SizedBox(height: 12),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _dislikeOptions.map((option) {
                  final isSelected = _selectedDislikes.contains(option);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedDislikes.remove(option);
                        } else {
                          _selectedDislikes.add(option);
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? JAppColors.primary.withOpacity(0.15)
                            : widget.isDark
                            ? JAppColors.darkGray700
                            : JAppColors.lightGray200,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected
                              ? JAppColors.primary
                              : widget.isDark
                              ? JAppColors.darkGray600
                              : JAppColors.lightGray300,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        option,
                        style: AppTextStyle.dmSans(
                          fontSize: 13.0,
                          color: isSelected
                              ? JAppColors.primary
                              : widget.isDark
                              ? JAppColors.darkGray300
                              : JAppColors.lightGray700,
                          weight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Leave a Review
              Text(
                'Leave a Review?',
                style: AppTextStyle.dmSans(
                  fontSize: 15.0,
                  weight: FontWeight.w600,
                  color: widget.isDark
                      ? JAppColors.darkGray100
                      : JAppColors.lightGray900,
                ),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: _reviewController,
                maxLines: 5,
                style: AppTextStyle.dmSans(
                  fontSize: 14.0,
                  color: widget.isDark
                      ? JAppColors.darkGray100
                      : JAppColors.lightGray900, weight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: 'This app is awesome',
                  hintStyle: AppTextStyle.dmSans(
                    fontSize: 14.0,
                    color: widget.isDark
                        ? JAppColors.darkGray500
                        : JAppColors.lightGray500,
                    weight: FontWeight.w400,
                  ),
                  filled: true,
                  fillColor: widget.isDark
                      ? JAppColors.darkGray700
                      : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: widget.isDark
                          ? JAppColors.darkGray600
                          : JAppColors.lightGray300,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: widget.isDark
                          ? JAppColors.darkGray600
                          : JAppColors.lightGray300,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: JAppColors.primary,
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 24),

              // Submit Button
              Center(
                child: SizedBox(
                  width: 180,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle submit
                      Navigator.pop(context, {
                        'rating': _rating,
                        'likes': _selectedLikes.toList(),
                        'dislikes': _selectedDislikes.toList(),
                        'review': _reviewController.text,
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: JAppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Submit',
                      style: AppTextStyle.dmSans(
                        fontSize: 16.0,
                        weight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}