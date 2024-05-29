import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/payment/domain/entities/hiring.dart';

class HiringModel extends Hiring {
  const HiringModel({
    required super.teacherId,
    required super.userId,
    required super.paidAt,
    required super.hourlyRate,
  });

  HiringModel copyWith({
    String? teacherId,
    String? userId,
    double? hourlyRate,
    DateTime? paidAt,
  }) =>
      HiringModel(
        teacherId: teacherId ?? this.teacherId,
        userId: userId ?? this.userId,
        hourlyRate: hourlyRate ?? this.hourlyRate,
        paidAt: paidAt ?? this.paidAt,
      );

  HiringModel.fromMap(DataMap map)
      : super(
          teacherId: map['teacherId'] as String,
          userId: map['userId'] as String,
          paidAt: (map['paidAt'] as Timestamp).toDate(),
          hourlyRate: (map['hourlyRate'] as num).toDouble(),
        );

  DataMap toMap() => {
        'teacherId': teacherId,
        'paidAt': paidAt,
        'userId': userId,
        'hourlyRate': hourlyRate,
      };
}
