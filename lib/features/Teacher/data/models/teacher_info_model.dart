import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Teacher/domain/entities/teacher_info.dart';

class TeacherInfoModel extends TeacherInfo {
  const TeacherInfoModel({
    required super.id,
    required super.userId,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phoneNumber,
    required super.languageSpoken,
    required super.subjectTaught,
    required super.profilePic,
    required super.university,
    required super.degree,
    required super.degreeType,
    required super.fromYearOfStudy,
    required super.toYearOfStudy,
    required super.headline,
    required super.description,
    required super.availabilityDates,
    required super.availabilityFromTimes,
    required super.availabilityToTimes,
    required super.hourlyRate,
    required super.country,
    super.isProfilePicFile,
    required super.specialization,
  });

  TeacherInfoModel.empty()
      : this(
          id: '',
          userId: '',
          firstName: '',
          lastName: '',
          email: '',
          phoneNumber: '',
          languageSpoken: '',
          subjectTaught: '',
          profilePic: null,
          university: '',
          degree: '',
          degreeType: '',
          fromYearOfStudy: '',
          toYearOfStudy: '',
          headline: '',
          description: '',
          availabilityDates: [],
          availabilityFromTimes: [],
          availabilityToTimes: [],
          hourlyRate: 10,
          country: '',
          specialization: '',
        );

  TeacherInfoModel copyWith({
    String? id,
    String? userId,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? languageSpoken,
    String? subjectTaught,
    String? profilePic,
    String? university,
    String? degree,
    String? degreeType,
    String? fromYearOfStudy,
    String? toYearOfStudy,
    String? headline,
    String? description,
    List<String>? availabilityDates,
    List<String>? availabilityFromTimes,
    List<String>? availabilityToTimes,
    double? hourlyRate,
    bool? isProfilePicFile,
    String? country,
    String? specialization,
  }) =>
      TeacherInfoModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        languageSpoken: languageSpoken ?? this.languageSpoken,
        subjectTaught: subjectTaught ?? this.subjectTaught,
        profilePic: profilePic ?? this.profilePic,
        university: university ?? this.university,
        degree: degree ?? this.degree,
        degreeType: degreeType ?? this.degreeType,
        specialization: specialization ?? this.specialization,
        fromYearOfStudy: fromYearOfStudy ?? this.fromYearOfStudy,
        toYearOfStudy: toYearOfStudy ?? this.toYearOfStudy,
        headline: headline ?? this.headline,
        description: description ?? this.description,
        availabilityDates: availabilityDates ?? this.availabilityDates,
        availabilityFromTimes:
            availabilityFromTimes ?? this.availabilityFromTimes,
        availabilityToTimes: availabilityToTimes ?? this.availabilityToTimes,
        hourlyRate: hourlyRate ?? this.hourlyRate,
        isProfilePicFile: isProfilePicFile ?? this.isProfilePicFile,
        country: country ?? this.country,
      );

  DataMap toMap() => {
        'id': id,
        'userId': userId,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'languageSpoken': languageSpoken,
        'subjectTaught': subjectTaught,
        'profilePic': profilePic,
        'university': university,
        'degree': degree,
        'degreeType': degreeType,
        'fromYearOfStudy': fromYearOfStudy,
        'toYearOfStudy': toYearOfStudy,
        'headline': headline,
        'description': description,
        'availabilityDates': availabilityDates,
        'availabilityFromTimes': availabilityFromTimes,
        'availabilityToTimes': availabilityToTimes,
        'hourlyRate': hourlyRate,
        'country': country,
        'specialization': specialization,
      };

  TeacherInfoModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          userId: map['userId'] as String,
          firstName: map['firstName'] as String,
          lastName: map['lastName'] as String,
          email: map['email'] as String,
          phoneNumber: map['phoneNumber'] as String,
          languageSpoken: map['languageSpoken'] as String,
          subjectTaught: map['subjectTaught'] as String,
          profilePic: map['profilePic'] as String?,
          university: map['university'],
          degree: map['degree'] as String,
          degreeType: map['degreeType'] as String,
          fromYearOfStudy: map['fromYearOfStudy'] as String,
          toYearOfStudy: map['toYearOfStudy'] as String,
          headline: map['headline'] as String,
          specialization: map['specialization'] as String,
          description: map['description'] as String,
          availabilityDates: (map['availabilityDates'] as List).cast<String>(),
          availabilityFromTimes:
              (map['availabilityFromTimes'] as List).cast<String>(),
          availabilityToTimes:
              (map['availabilityToTimes'] as List).cast<String>(),
          hourlyRate: (map['hourlyRate'] as num).toDouble(),
          isProfilePicFile: map['isProfilePicFile'] as bool?,
          country: map['country'] as String,
        );
}