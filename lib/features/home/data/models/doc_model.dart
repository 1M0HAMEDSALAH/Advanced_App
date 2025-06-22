class DoctorModel {
  final int doctorId;
  final int partyId;
  final String name;
  final String specialization;
  final String strNumber;
  final double rating;
  final int reviewCount;
  final String about;
  final String workingTime;
  final String practicePlace;
  final String locationMap;
  final DateTime createdAt;
  final List<ReviewModel> reviews;
  final PartyModel party;

  DoctorModel({
    required this.doctorId,
    required this.partyId,
    required this.name,
    required this.specialization,
    required this.strNumber,
    required this.rating,
    required this.reviewCount,
    required this.about,
    required this.workingTime,
    required this.practicePlace,
    required this.locationMap,
    required this.createdAt,
    required this.reviews,
    required this.party,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    try {
      return DoctorModel(
        doctorId: _parseInt(json['DoctorID']),
        partyId: _parseInt(json['PartyID']),
        name: json['DoctorName']?.toString() ?? '',
        specialization: json['Specialization']?.toString() ?? '',
        strNumber: json['STRNumber']?.toString() ?? '',
        rating: _parseDouble(json['Rating']),
        reviewCount: _parseInt(json['ReviewCount']),
        about: json['About']?.toString() ?? '',
        workingTime: json['WorkingTime']?.toString() ?? '',
        practicePlace: json['PracticePlace']?.toString() ?? '',
        locationMap: json['LocationMap']?.toString() ?? '',
        createdAt: _parseDateTime(json['CreatedAt']),
        reviews: _parseReviews(json['Reviews']),
        party: PartyModel.fromJson(json['Party'] ?? {}),
      );
    } catch (e) {
      throw Exception('Error parsing DoctorModel: $e\nJSON: $json');
    }
  }

  // Helper methods for safe parsing
  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is String) {
      return DateTime.tryParse(value) ?? DateTime.now();
    }
    return DateTime.now();
  }

  static List<ReviewModel> _parseReviews(dynamic value) {
    if (value == null || value is! List) return [];
    return value
        .map<ReviewModel>((item) => ReviewModel.fromJson(item))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'DoctorID': doctorId,
      'PartyID': partyId,
      'DoctorName': name,
      'Specialization': specialization,
      'STRNumber': strNumber,
      'Rating': rating.toString(),
      'ReviewCount': reviewCount,
      'About': about,
      'WorkingTime': workingTime,
      'PracticePlace': practicePlace,
      'LocationMap': locationMap,
      'CreatedAt': createdAt.toIso8601String(),
      'Reviews': reviews.map((review) => review.toJson()).toList(),
      'Party': party.toJson(),
    };
  }
}

class ReviewModel {
  final String reviewerName;
  final String reviewerImage;
  final String reviewText;
  final double rating;
  final DateTime reviewDate;

  ReviewModel({
    required this.reviewerName,
    required this.reviewerImage,
    required this.reviewText,
    required this.rating,
    required this.reviewDate,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      reviewerName: json['ReviewerName']?.toString() ?? '',
      reviewerImage: json['ReviewerImage']?.toString() ?? '',
      reviewText: json['ReviewText']?.toString() ?? '',
      rating: DoctorModel._parseDouble(json['Rating']),
      reviewDate: DoctorModel._parseDateTime(json['ReviewDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ReviewerName': reviewerName,
      'ReviewText': reviewText,
      'Rating': rating.toString(),
      'ReviewDate': reviewDate.toIso8601String(),
      'ReviewerImage': reviewerImage
    };
  }
}

class PartyModel {
  final String fullName;
  final String phoneNumber;
  final String email;
  final String gender;

  PartyModel({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.gender,
  });

  factory PartyModel.fromJson(Map<String, dynamic> json) {
    return PartyModel(
      fullName: json['FullName']?.toString() ?? '',
      phoneNumber: json['PhoneNumber']?.toString() ?? '',
      email: json['Email']?.toString() ?? '',
      gender: json['Gender']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'FullName': fullName,
      'PhoneNumber': phoneNumber,
      'Email': email,
      'Gender': gender,
    };
  }
}
