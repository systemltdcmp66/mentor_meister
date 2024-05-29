import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/entities/user.dart';

class LocalUserModel extends LocaleUser {
  const LocalUserModel({
    required super.uid,
    required super.name,
    required super.email,
    required super.phoneNumber,
    super.points,
    super.bio,
    super.profilePic,
    super.groupIds,
    super.enrolledCourseIds,
    super.hiredTeacherIds,
    super.followers,
    super.following,
    super.teacherId,
    super.isFirstTime,
    super.alreadyVisitTutorSignUpPage,
    super.alreadyVisitTutorAskPage,
  });

  const LocalUserModel.empty()
      : this(
          uid: '',
          name: '',
          email: '',
          phoneNumber: '+919654361924',
          points: 0,
        );

  LocalUserModel.fromMap(DataMap map)
      : this(
          uid: map['uid'] as String,
          name: map['name'] as String,
          email: map['email'] as String,
          phoneNumber: map['phoneNumber'] as String,
          points: (map['points'] as num).toInt(),
          bio: map['bio'] as String?,
          profilePic: map['profilePic'] as String?,
          groupIds: List<String>.from(map['groupIds'] as List<dynamic>),
          enrolledCourseIds: (map['enrolledCourseIds'] as List).cast<String>(),
          hiredTeacherIds: (map['hiredTeacherIds'] as List).cast<String>(),
          followers: List<String>.from(map['followers'] as List),
          following: List<String>.from(map['following'] as List<dynamic>),
          teacherId: map['teacherId'] as String?,
          isFirstTime: map['isFirstTime'] as bool?,
          alreadyVisitTutorSignUpPage:
              map['alreadyVisitTutorSignUpPage'] as bool?,
          alreadyVisitTutorAskPage: map['alreadyVisitTutorAskPage'] as bool?,
        );

  DataMap toMap() => {
        'uid': uid,
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'points': points,
        'bio': bio,
        'profilePic': profilePic,
        'groupIds': groupIds,
        'enrolledCourseIds': enrolledCourseIds,
        'hiredTeacherIds': hiredTeacherIds,
        'followers': followers,
        'following': following,
        'teacherId': teacherId,
        'isFirstTime': isFirstTime,
        'alreadyVisitTutorSignUpPage': alreadyVisitTutorSignUpPage,
        'alreadyVisitTutorAskPage': alreadyVisitTutorAskPage,
      };

  LocalUserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? phoneNumber,
    String? bio,
    String? profilePic,
    int? points,
    List<String>? enrolledCourseIds,
    List<String>? hiredTeacherIds,
    List<String>? groupIds,
    List<String>? followers,
    List<String>? following,
    String? teacherId,
    bool? isFirstTime,
    bool? alreadyVisitTutorSignUpPage,
    bool? alreadyVisitTutorAskPage,
  }) =>
      LocalUserModel(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        points: points ?? this.points,
        bio: bio ?? this.bio,
        profilePic: profilePic ?? this.profilePic,
        enrolledCourseIds: enrolledCourseIds ?? this.enrolledCourseIds,
        hiredTeacherIds: hiredTeacherIds ?? this.hiredTeacherIds,
        followers: followers ?? this.followers,
        following: following ?? this.following,
        teacherId: teacherId ?? this.teacherId,
        isFirstTime: isFirstTime ?? this.isFirstTime,
        alreadyVisitTutorSignUpPage:
            alreadyVisitTutorSignUpPage ?? this.alreadyVisitTutorSignUpPage,
        alreadyVisitTutorAskPage:
            alreadyVisitTutorAskPage ?? this.alreadyVisitTutorAskPage,
      );
}
