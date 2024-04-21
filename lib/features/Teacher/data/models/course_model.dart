import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Teacher/domain/entities/course.dart';

class CourseModel extends Course {
  const CourseModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.type,
    required super.price,
    required super.numberOfAssignments,
    required super.numberOfExams,
    required super.numberOfQuizzes,
    required super.isImageFile,
    required super.lessons,
    required super.groupId,
    required super.createdAt,
    required super.updatedAt,
    super.image,
    super.numberOfStudents,
  });

  CourseModel.empty()
      : this(
          id: '',
          userId: '',
          title: '',
          type: '',
          price: 0,
          numberOfAssignments: 0,
          numberOfExams: 0,
          numberOfQuizzes: 0,
          isImageFile: true,
          lessons: null,
          groupId: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
  CourseModel copyWith({
    String? id,
    String? userId,
    String? title,
    double? price,
    String? type,
    int? numberOfAssignments,
    int? numberOfExams,
    int? numberOfQuizzes,
    int? numberOfStudents,
    bool? isImageFile,
    File? lessons,
    String? groupId,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      CourseModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        type: type ?? this.type,
        price: price ?? this.price,
        numberOfAssignments: numberOfAssignments ?? this.numberOfAssignments,
        numberOfExams: numberOfExams ?? this.numberOfExams,
        numberOfQuizzes: numberOfQuizzes ?? this.numberOfQuizzes,
        numberOfStudents: numberOfStudents ?? this.numberOfStudents,
        isImageFile: isImageFile ?? this.isImageFile,
        lessons: lessons ?? this.lessons,
        groupId: groupId ?? this.groupId,
        image: image ?? this.image,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  CourseModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          userId: map['userId'] as String,
          title: map['title'] as String,
          type: map['type'] as String,
          price: (map['price'] as num).toDouble(),
          numberOfAssignments: (map['numberOfAssignments'] as num).toInt(),
          numberOfExams: (map['numberOfExams'] as num).toInt(),
          numberOfQuizzes: (map['numberOfQuizzes'] as num).toInt(),
          numberOfStudents: (map['numberOfStudents'] as num).toInt(),
          isImageFile: map['isImageFile'] as bool,
          image: map['image'] as String?,
          lessons: map['lessons'] as File?,
          groupId: map['groupId'] as String,
          createdAt: (map['createdAt'] as Timestamp).toDate(),
          updatedAt: (map['updatedAt'] as Timestamp).toDate(),
        );

  DataMap toMap() => {
        'id': id,
        'userId': userId,
        'title': title,
        'price': price,
        'type': type,
        'numberOfAssignments': numberOfAssignments,
        'numberOfExams': numberOfExams,
        'numberOfQuizzes': numberOfQuizzes,
        'numberOfStudents': numberOfStudents,
        'image': image,
        'lessons': lessons,
        'isImageFile': isImageFile,
        'groupId': groupId,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };
}
