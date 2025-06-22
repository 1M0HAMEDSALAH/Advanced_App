import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'review_text.dart';
import 'reviewer_avatar.dart';
import 'reviewer_info.dart';

class ReviewItem extends StatelessWidget {
  final String name;
  final int rating;
  final String time;
  final String review;
  final String profileImageUrl;

  const ReviewItem({
    super.key,
    required this.name,
    required this.rating,
    required this.time,
    required this.review,
    this.profileImageUrl = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ReviewerAvatar(profileImageUrl: profileImageUrl),
              SizedBox(width: 12.w),
              Expanded(
                  child: ReviewerInfo(
                name: name,
                rating: rating,
                time: time,
              )),
            ],
          ),
          SizedBox(height: 12.h),
          ReviewText(review: review),
        ],
      ),
    );
  }
}
