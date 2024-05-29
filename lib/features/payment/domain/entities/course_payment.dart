import 'package:equatable/equatable.dart';

class CoursePayment extends Equatable {
  const CoursePayment({
    required this.customerId,
    required this.customerEmail,
    required this.paymentId,
    required this.paymentType,
    required this.courseName,
    required this.courseprice,
    required this.paidAt,
    required this.courseId,
  });

  final String customerId;
  final String customerEmail;
  final String paymentId;
  final String paymentType;
  final String courseName;
  final String courseId;
  final double courseprice;
  final DateTime paidAt;
  @override
  List<Object?> get props => [
        customerId,
        customerEmail,
        paymentId,
        courseId,
      ];
}
