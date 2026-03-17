import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../data/models/jobs/job_list_item_model.dart';
import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/circular_avatar.dart';
import '../../../../utils/common_widgets/job_card.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/device/device_utility.dart';
import '../account_screen/provider/recent_job_provider.dart';
import '../home/job_details/JobDetailScreen.dart';
import '../providers/job_provider.dart';



class ViewAllJobsScreen extends StatefulWidget {
  const ViewAllJobsScreen({super.key});

  @override
  State<ViewAllJobsScreen> createState() => _ViewAllJobsScreenState();
}

class _ViewAllJobsScreenState extends State<ViewAllJobsScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      appBar: JAppbar(
        leadingIcon: GestureDetector(
          onTap: () => context.pop(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_back,
              color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
              size: 24,
            ),
          ),
        ),
        title: Text(
          'All Recent Posted Jobs',
          style: AppTextStyle.dmSans(
            fontSize: 18.0,
            weight: FontWeight.w600,
            color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
          ),
        ),
        actions: [
          // Profile avatar
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),



            Consumer<JobProvider>(
              builder: (context, jobProvider, child) {
                if (jobProvider.isLoading) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (jobProvider.errorMessage != null) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Internet Issue',
                            style: AppTextStyle.dmSans(
                              fontSize: 14.0,
                              weight: FontWeight.w500,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              jobProvider.fetchJobs();
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final jobs = jobProvider.paginatedJobs?.jobs ?? [];

                if (jobs.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text(
                        'No jobs available',
                        style: AppTextStyle.dmSans(
                          fontSize: 14.0,
                          weight: FontWeight.w400,
                          color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray500,
                        ),
                      ),
                    ),
                  );
                }

                // Display first 4 jobs
                final displayJobs = jobs.toList();

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: displayJobs.length,
                  itemBuilder: (context, index) {
                    final job = displayJobs[index];

                    // Wrap in try-catch to identify the exact error
                    try {
                      return JobCard(
                        isDark: isDark,
                        title: job.title,
                        location: _getLocationString(job.jobLocation),
                        workType: job.jobType,
                        salary: job.salary,
                        category: job.jobCategory,
                        duration: job.jobDuration ,
                        skills: job.skillsRequired.map((s) => s.name).toList(),
                        experience: job.experience,
                        postedAgo: _getTimeAgo(job.createdAt),
                        onViewDetails: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JobDetailScreen(
                                jobId: job.id,
                                jobData: {
                                  'title': job.title,
                                  'description': job.description,
                                  'responsibilities': '',
                                  'skillsRequired': job.skillsRequired.map((s) => s.name).toList(),
                                  'category': job.jobCategory,
                                  'duration': job.jobDuration,
                                  'experience': job.experience,
                                  'salary': job.salary,
                                  'workType': job.jobType,
                                  'location': _getLocationString(job.jobLocation),
                                  'clientHistory': '',
                                  'isSaved': true,
                                },
                              ),
                            ),
                          );
                        },
                      );
                    } catch (e) {
                      // Fallback card to show error details
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.red),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Error loading job card',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Error: $e',
                              style: TextStyle(
                                color: Colors.red[700],
                                fontSize: 12.0,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Job Title: ${job.title}',
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                );
              },
            ),

            const SizedBox(height: 80), // Bottom spacing
          ],
        ),
      ),
    );
  }
  // Helper method to get location string from coordinates
  String _getLocationString(JobLocation location) {
    if (location.coordinates.isNotEmpty) {
      return 'Lat: ${location.coordinates[1].toStringAsFixed(2)}, Lng: ${location.coordinates[0].toStringAsFixed(2)}';
    }
    return 'Location not available';
  }

  String _getTimeAgo(String createdAt) {
    try {
      final dateTime = DateTime.parse(createdAt);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inDays > 365) {
        final years = (difference.inDays / 365).floor();
        return '$years ${years == 1 ? 'year' : 'years'} ago';
      } else if (difference.inDays > 30) {
        final months = (difference.inDays / 30).floor();
        return '$months ${months == 1 ? 'month' : 'months'} ago';
      } else if (difference.inDays > 0) {
        return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return 'Recently';
    }
  }

}

