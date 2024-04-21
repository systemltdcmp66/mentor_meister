import 'package:equatable/equatable.dart';

class TeacherInfo extends Equatable {
  const TeacherInfo({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.languageSpoken,
    required this.subjectTaught,
    required this.profilePic,
    required this.university,
    required this.degree,
    required this.degreeType,
    required this.fromYearOfStudy,
    required this.toYearOfStudy,
    required this.headline,
    required this.description,
    required this.availabilityDates,
    required this.availabilityFromTimes,
    required this.availabilityToTimes,
    required this.hourlyRate,
    required this.country,
    this.isProfilePicFile = false,
    required this.specialization,
  });

  final String id;
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String country;
  final String specialization;
  final String languageSpoken;
  final String subjectTaught;
  final String? profilePic;
  final String university;
  final String degree;
  final String degreeType;
  final String fromYearOfStudy;
  final String toYearOfStudy;
  final String headline;
  final String description;
  final List<String> availabilityDates;
  final List<String> availabilityFromTimes;
  final List<String> availabilityToTimes;
  final double hourlyRate;
  final bool? isProfilePicFile;

  @override
  List<Object?> get props => [
        id,
        userId,
        firstName,
        lastName,
        email,
        phoneNumber,
        languageSpoken,
        subjectTaught,
        profilePic,
        university,
        degree,
        degreeType,
        fromYearOfStudy,
        toYearOfStudy,
        headline,
        description,
        availabilityDates,
        availabilityFromTimes,
        availabilityToTimes,
        hourlyRate,
        country,
        specialization,
      ];
}
