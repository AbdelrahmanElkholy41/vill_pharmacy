import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../home/presentation/screens/customer_home.dart';
import '../../data/models/create_order_request_model.dart';
import '../cubit/order_cubit.dart';
import '../cubit/order_state.dart';
import '../widget/PrescriptionUploadTile.dart';

class Pharmacy {
  final String id;
  final String name;
  final double rating;
  final String distance;
  final bool isOpen;

  const Pharmacy({
    required this.id,
    required this.name,
    required this.rating,
    required this.distance,
    required this.isOpen,
  });
}

class NewOrderScreen extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback? onOrderSent;

  const NewOrderScreen({super.key, required this.onBack, this.onOrderSent});

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  final _controller = TextEditingController();
  final _imagePicker = ImagePicker();

  String? _selectedPharmacyId;
  File? _prescriptionImage;

  final List<Pharmacy> _pharmacies = const [
    Pharmacy(
      id: '1',
      name: 'صيدلية النور',
      rating: 4.5,
      distance: '500م',
      isOpen: true,
    ),
    Pharmacy(
      id: '2',
      name: 'صيدلية الشفاء',
      rating: 4.8,
      distance: '800م',
      isOpen: true,
    ),
    Pharmacy(
      id: '3',
      name: 'صيدلية الحياة',
      rating: 4.2,
      distance: '1.2كم',
      isOpen: false,
    ),
  ];

  bool get _canSubmit =>
      _controller.text.trim().isNotEmpty || _prescriptionImage != null;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  Future<void> _pickPrescriptionImage() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined,
                    color: Color(0xFF22C55E)),
                title: const Text('التقاط صورة بالكاميرا'),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined,
                    color: Color(0xFF22C55E)),
                title: const Text('اختيار من المعرض'),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );

    if (source == null) return;

    try {
      final picked = await _imagePicker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1600,
      );
      if (picked == null) return;
      setState(() => _prescriptionImage = File(picked.path));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذر فتح الكاميرا أو المعرض')),
      );
    }
  }

  void _removeImage() => setState(() => _prescriptionImage = null);

  void _submitOrder(BuildContext context) {
    if (!_canSubmit) return;
    context.read<CreateOrderCubit>().createOrder(
      CreateOrderRequestModel(
        details: _controller.text.trim(),
        pharmacyId: _selectedPharmacyId,
        prescriptionImage: _prescriptionImage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateOrderCubit, CreateOrderState>(
      listener: (context, state) {
        if (state is CreateOrderSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم إرسال الطلب بنجاح')),
          );
          widget.onOrderSent?.call();
        } else if (state is CreateOrderError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final isSubmitting = state is CreateOrderLoading;
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: const Color(0xFFF8FAFC),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: widget.onBack,
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.arrow_forward,
                                    size: 16, color: Color(0xFF22C55E)),
                                SizedBox(width: 4),
                                Text('رجوع',
                                    style: TextStyle(
                                        color: Color(0xFF22C55E),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Center(
                            child: Text('طلب جديد',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF111827))),
                          ),
                          const SizedBox(height: 24),
                          const Text('تفاصيل الطلب',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF111827))),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border:
                              Border.all(color: const Color(0xFFE5E7EB)),
                            ),
                            child: TextField(
                              controller: _controller,
                              textDirection: TextDirection.rtl,
                              maxLines: 4,
                              onChanged: (_) => setState(() {}),
                              decoration: const InputDecoration(
                                hintText: 'اكتب اسم الدواء أو تفاصيل الطلب',
                                hintStyle: TextStyle(
                                    color: Color(0xFFBBBBBB), fontSize: 14),
                                contentPadding: EdgeInsets.all(14),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          PrescriptionUploadTile(
                            image: _prescriptionImage,
                            onTap: _pickPrescriptionImage,
                            onRemove: _removeImage,
                          ),
                          const SizedBox(height: 20),
                          const Text('اختر صيدلية (اختياري)',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF111827))),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 110,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: _pharmacies.length,
                              separatorBuilder: (_, __) =>
                              const SizedBox(width: 10),
                              itemBuilder: (_, i) {
                                final p = _pharmacies[i];
                                final sel = _selectedPharmacyId == p.id;
                                return GestureDetector(
                                  onTap: p.isOpen
                                      ? () => setState(() =>
                                  _selectedPharmacyId =
                                  sel ? null : p.id)
                                      : null,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    width: 145,
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: sel
                                          ? const Color(0xFFDCFCE7)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: sel
                                            ? const Color(0xFF22C55E)
                                            : const Color(0xFFE5E7EB),
                                        width: sel ? 2 : 1,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        Text(p.name,
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: p.isOpen
                                                    ? const Color(0xFF111827)
                                                    : const Color(
                                                    0xFF9CA3AF))),
                                        const SizedBox(height: 4),
                                        Row(children: [
                                          const Text('📍',
                                              style: TextStyle(fontSize: 10)),
                                          const SizedBox(width: 2),
                                          Text(p.distance,
                                              style: const TextStyle(
                                                  fontSize: 11,
                                                  color: Color(0xFF6B7280))),
                                          const SizedBox(width: 4),
                                          const Text('⭐',
                                              style: TextStyle(fontSize: 10)),
                                          const SizedBox(width: 2),
                                          Text(p.rating.toString(),
                                              style: const TextStyle(
                                                  fontSize: 11,
                                                  color: Color(0xFF6B7280))),
                                        ]),
                                        const SizedBox(height: 4),
                                        Row(children: [
                                          Container(
                                            width: 7,
                                            height: 7,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: p.isOpen
                                                  ? const Color(0xFF22C55E)
                                                  : const Color(0xFFEF4444),
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(p.isOpen ? 'مفتوح' : 'مغلق',
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: p.isOpen
                                                      ? const Color(
                                                      0xFF22C55E)
                                                      : const Color(
                                                      0xFFEF4444))),
                                        ]),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: const Color(0xFFF8FAFC),
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (_canSubmit && !isSubmitting)
                            ? () => _submitOrder(context)
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _canSubmit
                              ? const Color(0xFF22C55E)
                              : const Color(0xFFD1D5DB),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: _canSubmit ? 3 : 0,
                        ),
                        child: isSubmitting
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('إرسال الطلب',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(width: 8),
                            Text('🚀', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
