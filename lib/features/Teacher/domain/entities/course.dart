import 'dart:io';
import 'package:equatable/equatable.dart';

class Course extends Equatable {
  const Course({
    required this.id,
    required this.userId,
    required this.title,
    required this.type,
    required this.price,
    required this.numberOfAssignments,
    required this.numberOfExams,
    required this.numberOfQuizzes,
    this.image,
    this.numberOfStudents = 0,
    required this.isImageFile,
    required this.lessons,
    required this.groupId,
    required this.createdAt,
    required this.updatedAt,
  });
  final String id;
  final String userId;
  final String title;
  final String type;
  final double price;
  final int numberOfAssignments;
  final int numberOfQuizzes;
  final int numberOfExams;
  final int? numberOfStudents;
  final String? image;
  final bool isImageFile;
  final File? lessons;
  final String groupId;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
        id,
        userId,
        title,
        type,
        price,
        numberOfAssignments,
        numberOfQuizzes,
        numberOfExams,
        image,
        isImageFile,
        groupId,
        numberOfAssignments,
        createdAt,
        updatedAt,
      ];
}
