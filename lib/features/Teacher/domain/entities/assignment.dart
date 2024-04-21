import 'dart:io';

import 'package:equatable/equatable.dart';

class XAssignment extends Equatable {
  const XAssignment({
    required this.id,
    required this.courseName,
    required this.isAssignmentFile,
    required this.assignmentNumber,
    required this.courseId,
    this.question,
    this.assignmentFile,
  });

  final String id;
  final String courseId;
  final String courseName;
  final int assignmentNumber;
  final String? question;
  final File? assignmentFile;
  final bool isAssignmentFile;

  @override
  List<Object?> get props => [
        courseId,
        id,
        courseName,
        assignmentFile,
        assignmentNumber,
        isAssignmentFile,
        question,
      ];
}
