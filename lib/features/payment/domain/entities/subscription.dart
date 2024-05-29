import 'package:equatable/equatable.dart';

class Subscription extends Equatable {
  const Subscription({
    required this.teacherId,
    required this.teacherEmail,
    required this.paymentType,
    required this.paymentId,
    required this.paidAt,
    this.type = 'free',
    this.price = 0,
  });
  final String teacherId;
  final String teacherEmail;
  final String paymentId;
  final String paymentType;
  final String? type;
  final double? price;
  final DateTime paidAt;
  @override
  List<Object?> get props => [
        teacherId,
        teacherEmail,
        paymentId,
      ];
}
