import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mentormeister/core/utils/typedefs.dart';
import 'package:mentormeister/features/payment/domain/entities/subscription.dart';

class SubscriptionModel extends Subscription {
  const SubscriptionModel({
    required super.teacherId,
    required super.teacherEmail,
    required super.paymentType,
    required super.paymentId,
    required super.paidAt,
    super.type = 'free',
    super.price = 0,
  });

  SubscriptionModel copyWith({
    String? teacherId,
    String? teacherEmail,
    String? paymentId,
    String? paymentType,
    String? type,
    double? price,
    DateTime? paidAt,
  }) =>
      SubscriptionModel(
        teacherId: teacherId ?? this.teacherId,
        teacherEmail: teacherEmail ?? this.teacherEmail,
        paymentType: paymentType ?? this.paymentType,
        paymentId: paymentId ?? this.paymentId,
        paidAt: paidAt ?? this.paidAt,
        price: price ?? this.price,
        type: type ?? this.type,
      );

  SubscriptionModel.fromMap(DataMap map)
      : super(
          teacherId: map['teacherId'] as String,
          teacherEmail: map['teacherEmail'] as String,
          paymentType: map['paymentType'] as String,
          paymentId: map['paymentId'] as String,
          paidAt: (map['paidAt'] as Timestamp).toDate(),
          price: (map['price'] as num).toDouble(),
          type: map['type'] as String?,
        );

  DataMap toMap() => {
        'teacherId': teacherId,
        'teacherEmail': teacherEmail,
        'paymentType': paymentType,
        'paymentId': paymentId,
        'paidAt': paidAt,
        'price': price,
        'type': type,
      };
}
