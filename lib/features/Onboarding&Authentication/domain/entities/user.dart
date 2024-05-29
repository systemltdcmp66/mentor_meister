import 'package:equatable/equatable.dart';

class LocaleUser extends Equatable {
  const LocaleUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.profilePic,
    this.bio,
    this.points = 0,
    this.isFirstTime = true,
    this.alreadyVisitTutorSignUpPage = false,
    this.alreadyVisitTutorAskPage = false,
    this.enrolledCourseIds = const [],
    this.hiredTeacherIds = const [],
    this.followers = const [],
    this.following = const [],
    this.groupIds = const [],
    this.teacherId,
  });

  const LocaleUser.empty()
      : this(
          uid: '',
          name: '',
          email: '',
          phoneNumber: '+919654361924',
          points: 0,
        );

  final String uid; // Because Firebase uid is a String
  final String name;
  final String email;
  final String phoneNumber;
  final String? profilePic;
  final String? bio;
  final int? points;
  final List<String>? enrolledCourseIds;
  final List<String>? hiredTeacherIds;
  final List<String>? groupIds; // For chatting
  final List<String>? followers;
  final List<String>? following;
  final String? teacherId;
  final bool? isFirstTime;
  final bool? alreadyVisitTutorSignUpPage;
  final bool? alreadyVisitTutorAskPage;

  @override
  List<Object?> get props => [
        uid,
        name,
        email,
        profilePic,
        points,
        bio,
        enrolledCourseIds!.length,
        groupIds!.length,
        followers!.length,
        following!.length,
        hiredTeacherIds!.length,
      ];
}
