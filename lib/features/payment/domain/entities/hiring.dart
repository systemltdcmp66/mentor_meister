import 'package:equatable/equatable.dart';

class Hiring extends Equatable {
  const Hiring({
    required this.hourlyRate,
    required this.paidAt,
    required this.teacherId,
    required this.userId,
  });

  final String userId;
  final String teacherId;
  final double hourlyRate;
  final DateTime paidAt;

  @override
  List<Object?> get props => [
        userId,
        teacherId,
        paidAt,
        hourlyRate,
      ];
}
