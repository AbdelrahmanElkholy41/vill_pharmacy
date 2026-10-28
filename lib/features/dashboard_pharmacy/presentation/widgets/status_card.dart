
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/modal/all_order_modal.dart';

class StatusCard extends StatelessWidget {
  final AllOrderModal order;

  const StatusCard({
    super.key,
    required this.order,
  });

  bool get isDelivering =>
      order.status == 'accepted' || order.status == 'preparing';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 17.sp,
                    color: Colors.grey.shade700,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    order.isTargeted ? 'موجّه للصيدلية' : 'طلب جديد',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'رقم: ${order.orderNumber}',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 9.w,
                  vertical: 5.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  isDelivering ? 'في الطريق' : 'تم التوصيل',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.purple,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Order details
          Text(
            order.details,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF222222),
            ),
          ),

          // Prescription image indicator
          if (order.hasPrescriptionImage) ...[
            SizedBox(height: 6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'يوجد صورة روشتة',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.green.shade700,
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.image_outlined,
                  size: 16.sp,
                  color: Colors.green.shade700,
                ),
              ],
            ),
          ],

          SizedBox(height: 12.h),
          Divider(height: 1, color: Colors.grey.shade200),
          SizedBox(height: 12.h),

          // Customer, address and price horizontally
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: _InfoItem(
                  icon: Icons.person_outline,
                  text: order.customer.fullName,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                flex: 4,
                child: _InfoItem(
                  icon: Icons.location_on_outlined,
                  text: order.customer.address ?? 'العنوان غير متوفر',
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                flex: 2,
                child: _InfoItem(
                  icon: Icons.payments_outlined,
                  text: '${order.price} ج',
                  color: Colors.green.shade700,
                  bold: true,
                ),
              ),
            ],
          ),

          SizedBox(height: 14.h),

          // Delivery status
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.09),
              borderRadius: BorderRadius.circular(9.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    isDelivering ? 'جاري التوصيل' : 'تم التوصيل بنجاح',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.green.shade700,
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                Icon(
                  isDelivering
                      ? Icons.delivery_dining_outlined
                      : Icons.check_circle_outline,
                  size: 18.sp,
                  color: Colors.green.shade700,
                ),
              ],
            ),
          ),

          // Reject button
          if (order.isTargeted) ...[
            SizedBox(height: 9.h),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  // اربط هنا دالة رفض الطلب الموجودة عندك.
                },
                icon: Icon(Icons.close, size: 16.sp),
                label: Text(
                  'رفض الطلب',
                  style: TextStyle(fontSize: 12.sp),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  minimumSize: Size(0, 36.h),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9.r),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? color;
  final bool bold;

  const _InfoItem({
    required this.icon,
    required this.text,
    this.color,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    final itemColor = color ?? AppColors.primaryDark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16.sp,
          color: color ?? Colors.purple.withOpacity(0.8),
        ),
        SizedBox(width: 4.w),
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.right,
            softWrap: true,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              color: itemColor,
            ),
          ),
        ),
      ],
    );
  }
}
