import 'package:flutter/material.dart';

import '../../../home/presentation/screens/home.dart';

class NewOrderScreen extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback? onOrderSent;

  const NewOrderScreen({super.key, required this.onBack, this.onOrderSent});

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  final _controller = TextEditingController();
  String? _selectedPharmacy;
  bool _hasImage = false;

  final List<Pharmacy> _pharmacies = const [
    Pharmacy(name: 'صيدلية النور', rating: 4.5, distance: '500م', isOpen: true),
    Pharmacy(
        name: 'صيدلية الشفاء', rating: 4.8, distance: '800م', isOpen: true),
    Pharmacy(
        name: 'صيدلية الحياة', rating: 4.2, distance: '1.2كم', isOpen: false),
  ];

  bool get _canSubmit => _controller.text.trim().isNotEmpty || _hasImage;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
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
                          border: Border.all(color: const Color(0xFFE5E7EB)),
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
                      GestureDetector(
                        onTap: () =>
                            setState(() => _hasImage = !_hasImage),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: _hasImage
                                  ? const Color(0xFF22C55E)
                                  : const Color(0xFFE5E7EB),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _hasImage
                                    ? Icons.check_circle
                                    : Icons.camera_alt_outlined,
                                color: _hasImage
                                    ? const Color(0xFF22C55E)
                                    : const Color(0xFF6B7280),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _hasImage
                                    ? 'تم رفع الصورة ✓'
                                    : 'رفع صورة روشتة',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: _hasImage
                                      ? const Color(0xFF22C55E)
                                      : const Color(0xFF374151),
                                ),
                              ),
                            ],
                          ),
                        ),
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
                            final sel = _selectedPharmacy == p.name;
                            return GestureDetector(
                              onTap: p.isOpen
                                  ? () => setState(() => _selectedPharmacy =
                              sel ? null : p.name)
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
                                                : const Color(0xFF9CA3AF))),
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
                                      Text(
                                          p.isOpen ? 'مفتوح' : 'مغلق',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: p.isOpen
                                                  ? const Color(0xFF22C55E)
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
                    onPressed: _canSubmit ? widget.onOrderSent : null,
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
                    child: Row(
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
  }
}