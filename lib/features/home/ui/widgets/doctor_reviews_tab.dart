import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/doc_model.dart';
import 'empty_reviews_state.dart';
import 'review_item.dart';

class DoctorReviewsTab extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorReviewsTab({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          if (doctor.reviews.isEmpty)
            const EmptyReviewsState()
          else
            ...doctor.reviews.map((review) => Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: ReviewItem(
                    name: review.reviewerName,
                    rating: review.rating.toInt(),
                    time: _formatReviewDate(review.reviewDate),
                    review: review.reviewText,
                    profileImageUrl: review.reviewerImage,
                  ),
                )),
        ],
      ),
    );
  }

  String _formatReviewDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) return 'Today';
    if (difference.inDays == 1) return 'Yesterday';
    if (difference.inDays < 7) return '${difference.inDays} days ago';
    if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    }
    return '${date.day}/${date.month}/${date.year}';
  }
}
