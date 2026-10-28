import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_app/core/helpers/spacing.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/modal/all_order_modal.dart';

class StatusCard extends StatelessWidget {
  final AllOrderModal order;

  const StatusCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        '📋',
                        style: TextStyle(fontSize: 13),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        order.isTargeted ? 'موجّه للصيدلية' : 'طلب جديد',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    ' رقم: ${order.orderNumber}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ]),
                    child: Text(
                      order.status == 'accepted' || order.status == 'preparing'
                          ? '  في الطريق  '
                          : '  تم التوصيل  ',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.purple,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      order.details,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF111827),
                      ),
                    ),
                  ),
                  if (order.hasPrescriptionImage) ...[
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '🖼️',
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(width: 4),
                        Text(
                          textAlign: TextAlign.end,
                          'يوجد صورة روشتة',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF22C55E),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 14),
              Row(children: [
                Icon(
                  Icons.person_3_sharp,
                  size: 18,
                  color: Colors.purple.withOpacity(0.8),
                ),
                horizontalSpace(4.w),
                Text(
                  order.customer.fullName,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryDark,
                  ),
                ),
                horizontalSpace(4.w),
                Icon(
                  Icons.home_outlined,
                  size: 18,
                  color: Colors.purple.withOpacity(0.8),
                ),
                horizontalSpace(4.w),
                Text(order.customer.address ?? ' العنوان غير متوفر  ',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.primaryDark,
                    )),
                horizontalSpace(4.w),
                Icon(Icons.monetization_on_outlined,
                    size: 18, color: Colors.purple.withOpacity(0.8)),
                horizontalSpace(4.w),
                Text(order.price.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    )),
                Text(
                  " جنية",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.withOpacity(0.8),
                  ),
                )
              ])
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      order.status == 'accepted' || order.status == 'preparing'
                          ? Text(
                              'جاري التوصيل ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.withOpacity(0.8),
                              ),
                            )
                          : Text(
                              'تم التوصيل بنجاح',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.withOpacity(0.8),
                              ),
                            ),
                      const SizedBox(width: 10),
                      order.status == 'accepted' || order.status == 'preparing'
                          ? Icon(
                              Icons.delivery_dining_outlined,
                              color: Colors.green.withOpacity(0.8),
                              size: 20,
                            )
                          : Icon(
                              Icons.check_circle,
                              color: Colors.green.withOpacity(0.8),
                              size: 20,
                            )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              order.isTargeted
                  ? Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEF4444),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          '✕ رفض',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
