import 'dart:io';

import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/Teacher/domain/entities/assignment.dart';

class AssignmentModel extends XAssignment {
  const AssignmentModel({
    required super.id,
    required super.courseName,
    required super.isAssignmentFile,
    required super.assignmentNumber,
    required super.courseId,
    super.assignmentFile,
    super.question,
  });

  const AssignmentModel.empty()
      : this(
          id: '',
          courseId: '',
          assignmentNumber: 1,
          isAssignmentFile: false,
          courseName: '',
        );

  AssignmentModel copyWith({
    String? id,
    String? courseId,
    bool? isAssignmentFile,
    int? assignmentNumber,
    File? assignmentFile,
    String? question,
    String? courseName,
  }) =>
      AssignmentModel(
        id: id ?? this.id,
        courseName: courseName ?? this.courseName,
        isAssignmentFile: isAssignmentFile ?? this.isAssignmentFile,
        assignmentNumber: assignmentNumber ?? this.assignmentNumber,
        courseId: courseId ?? this.courseId,
        assignmentFile: assignmentFile ?? this.assignmentFile,
        question: question ?? this.question,
      );

  AssignmentModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          courseId: map['courseId'] as String,
          courseName: map['courseName'] as String,
          assignmentNumber: (map['assignmentNumber'] as num).toInt(),
          isAssignmentFile: map['isAssignmentFile'] as bool,
          assignmentFile: map['assignmentFile'] as File?,
          question: map['question'] as String?,
        );

  DataMap toMap() => {
        'id': id,
        'courseId': courseId,
        'courseName': courseName,
        'question': question,
        'isAssignmentFile': isAssignmentFile,
        'assignmentNumber': assignmentNumber,
        'assignmentFile': assignmentFile,
      };
}
