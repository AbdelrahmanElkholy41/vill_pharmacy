import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class DialogCard extends StatefulWidget {
  const DialogCard({
    super.key,
    required this.onConfirm,
  });

  final void Function(double price, int deliveryTime) onConfirm;

  @override
  State<DialogCard> createState() => _DialogCardState();
}

class _DialogCardState extends State<DialogCard> {
  final _formKey = GlobalKey<FormState>();

  final _priceController = TextEditingController();
  final _deliveryTimeController = TextEditingController();

  @override
  void dispose() {
    _priceController.dispose();
    _deliveryTimeController.dispose();
    super.dispose();
  }

  void _handleConfirm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final price = double.parse(
      _priceController.text.trim(),
    );

    final deliveryTime = int.parse(
      _deliveryTimeController.text.trim(),
    );

    widget.onConfirm(price, deliveryTime);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'تحديد السعر ووقت التوصيل',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: _priceController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'السعر',
                    hintText: 'مثال: 75',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'من فضلك أدخل السعر';
                    }

                    final price = double.tryParse(value.trim());

                    if (price == null || price <= 0) {
                      return 'أدخل سعر صحيح';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 14),

                TextFormField(
                  controller: _deliveryTimeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'وقت التوصيل المتوقع',
                    hintText: 'مثال: 30 دقيقة',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'من فضلك أدخل وقت التوصيل';
                    }

                    final time = int.tryParse(value.trim());

                    if (time == null || time <= 0) {
                      return 'أدخل وقت صحيح بالدقائق';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 22),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('إلغاء'),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: _handleConfirm,
                        child: const Text('تأكيد'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}