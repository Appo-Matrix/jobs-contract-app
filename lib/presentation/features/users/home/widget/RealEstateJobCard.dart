import 'package:flutter/material.dart';

class RealEstateJobCard extends StatelessWidget {
  const RealEstateJobCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      width: 320,
      decoration: BoxDecoration(
        color: const Color(0xFF2D3542),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Hybrid badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    'Hybrid',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2D3542),
                    ),
                  ),
                ),

                // Salary range
                const Text(
                  '\$50,000 - \$90,000',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Job title
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Text(
              'Real Estate Agent',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),

          // Job details row
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Row(
              children: [
                // Real Estate category
                Row(
                  children: const [
                    Icon(
                      Icons.business_outlined,
                      size: 16,
                      color: Colors.white70,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Real Estate',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),

                // Full-time
                Row(
                  children: const [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 16,
                      color: Colors.white70,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Full-time',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Job description
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              'We are seeking a licensed Real Estate Agent to help clients buy, sell, and rent properties. Must...',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Divider
          const Divider(
            color: Colors.white12,
            thickness: 1,
            height: 1,
          ),

          // Employer info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Employer avatar with badge
                Stack(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1),
                        image: const DecorationImage(
                          image: NetworkImage('https://randomuser.me/api/portraits/women/44.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF2D3542), width: 1),
                        ),
                        child: const Icon(
                          Icons.verified_user,
                          size: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),

                // Employer details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Jennifer Williams',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 12,
                          color: Colors.white60,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'United States',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white60,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Icon(
                          Icons.access_time,
                          size: 12,
                          color: Colors.white60,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Posted 1 hr ago',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

