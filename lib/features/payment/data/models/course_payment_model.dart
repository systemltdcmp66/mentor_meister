import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/payment/domain/entities/course_payment.dart';

class CoursePaymentModel extends CoursePayment {
  const CoursePaymentModel({
    required super.customerId,
    required super.customerEmail,
    required super.paymentId,
    required super.courseId,
    required super.paymentType,
    required super.courseName,
    required super.courseprice,
    required super.paidAt,
  });

  CoursePaymentModel copyWith({
    String? customerId,
    String? customerEmail,
    String? paymentId,
    String? paymentType,
    String? courseName,
    String? courseId,
    double? courseprice,
    DateTime? paidAt,
  }) =>
      CoursePaymentModel(
        customerId: customerId ?? this.customerId,
        customerEmail: customerEmail ?? this.customerEmail,
        paymentId: paymentId ?? this.paymentId,
        paymentType: paymentType ?? this.paymentType,
        courseName: courseName ?? this.courseName,
        courseprice: courseprice ?? this.courseprice,
        paidAt: paidAt ?? this.paidAt,
        courseId: courseId ?? this.courseId,
      );

  CoursePaymentModel.fromMap(DataMap map)
      : super(
          customerId: map['customerId'] as String,
          customerEmail: map['customerEmail'] as String,
          paymentId: map['paymentId'] as String,
          paymentType: map['paymentType'] as String,
          courseName: map['courseName'] as String,
          courseprice: (map['courseprice'] as num).toDouble(),
          paidAt: (map['paidAt'] as Timestamp).toDate(),
          courseId: map['courseId'] as String,
        );

  DataMap toMap() => {
        'customerId': customerId,
        'customerEmail': customerEmail,
        'paymentId': paymentId,
        'paymentType': paymentType,
        'courseName': courseName,
        'courseprice': courseprice,
        'paidAt': FieldValue.serverTimestamp(),
        'courseId': courseId,
      };
}
