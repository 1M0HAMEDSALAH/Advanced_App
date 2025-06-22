import 'package:advanced_app/core/helpers/extentions.dart';
import 'package:advanced_app/core/themes/style.dart';
import 'package:advanced_app/features/auth/ui/widgets/customtextform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../logic/doctor_bloc.dart';

void showReviewDialog(BuildContext context, int DocId) {
  double rating = 0;
  final TextEditingController reviewController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Review'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                allowHalfRating: true,
                direction: Axis.horizontal,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (value) {
                  rating = value;
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                hintText: "Add Your Review Here",
                controller: reviewController,
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please write your review';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                final prefs = await SharedPreferences.getInstance();
                final reviewerName = prefs.getString('Username') ?? "";
                final reviewerImage = prefs.getString('Image') ?? "";
                final reviewText = reviewController.text;
                print('Rating: $rating');
                print('Review: $reviewText');
                print('Reviewer Name: $reviewerName');
                print('Doctor ID: $DocId');
                context.read<DoctorBloc>().add(
                      AddReviwForDoctor(
                          doctorId: DocId,
                          rating: rating,
                          reviewText: reviewText,
                          reviewerName: reviewerName,
                          reviewerImage: reviewerImage),
                    );
                context.pop();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Submit',
              style: TextStyles.font13GrayRegular.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    },
  );
}
