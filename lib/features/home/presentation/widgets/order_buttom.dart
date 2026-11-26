
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/extensions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/orders_palette.dart';
import '../cubit/pharmacy_near_cubit.dart';

class OrderButton extends StatelessWidget {
  const OrderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          final pharmacyCubit = context.read<PharmacyNearCubit>();

          context.pushNamed(
            Routes.newOrder,
            arguments: pharmacyCubit,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: OrdersPalette.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 4,
          shadowColor: const Color(0xFF22C55E).withOpacity(0.4),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'اطلب دواء الآن',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Text('💊', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
