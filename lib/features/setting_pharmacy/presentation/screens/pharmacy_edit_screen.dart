import 'package:flutter/material.dart';

/// -----------------------------------------------------------------------
/// Reuse the same AppColors as the profile screen.
/// If it's already defined in `core/constants/app_colors.dart`, delete this
/// block and import that file instead.
/// -----------------------------------------------------------------------
class AppColors {
  static const primaryGreen = Color(0xFF1E8E4F);
  static const lightGreenBg = Color(0xFFE9F7EF);
  static const scaffoldBg = Color(0xFFF4F6F8);
  static const cardBg = Colors.white;
  static const textDark = Color(0xFF1D2129);
  static const textGrey = Color(0xFF8A9099);
  static const red = Color(0xFFE5473A);
  static const borderGrey = Color(0xFFE3E6EA);
}

/// -----------------------------------------------------------------------
/// Data submitted when the pharmacist saves the form.
/// Map this to your Supabase update call / Cubit event.
/// -----------------------------------------------------------------------
class PharmacyEditData {
  final String name;
  final String pharmacistName;
  final String address;
  final TimeOfDay openTime;
  final TimeOfDay closeTime;
  final bool isOpen;

  const PharmacyEditData({
    required this.name,
    required this.pharmacistName,
    required this.address,
    required this.openTime,
    required this.closeTime,
    required this.isOpen,
  });
}

/// -----------------------------------------------------------------------
/// Screen
/// -----------------------------------------------------------------------
class PharmacyEditScreen extends StatefulWidget {
  final String initialName;
  final String initialPharmacistName;
  final String initialAddress;
  final TimeOfDay initialOpenTime;
  final TimeOfDay initialCloseTime;
  final bool initialIsOpen;

  /// Called with the new values when the pharmacist taps "حفظ التعديلات".
  final ValueChanged<PharmacyEditData>? onSave;

  const PharmacyEditScreen({
    super.key,
    required this.initialName,
    required this.initialPharmacistName,
    required this.initialAddress,
    required this.initialOpenTime,
    required this.initialCloseTime,
    required this.initialIsOpen,
    this.onSave,
  });

  @override
  State<PharmacyEditScreen> createState() => _PharmacyEditScreenState();
}

class _PharmacyEditScreenState extends State<PharmacyEditScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _pharmacistController;
  late final TextEditingController _addressController;

  late TimeOfDay _openTime;
  late TimeOfDay _closeTime;
  late bool _isOpen;

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _pharmacistController =
        TextEditingController(text: widget.initialPharmacistName);
    _addressController = TextEditingController(text: widget.initialAddress);
    _openTime = widget.initialOpenTime;
    _closeTime = widget.initialCloseTime;
    _isOpen = widget.initialIsOpen;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _pharmacistController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickTime({required bool isOpenTime}) async {
    final initial = isOpenTime ? _openTime : _closeTime;
    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
    );
    if (picked == null) return;
    setState(() {
      if (isOpenTime) {
        _openTime = picked;
      } else {
        _closeTime = picked;
      }
    });
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);
    try {
      widget.onSave?.call(
        PharmacyEditData(
          name: _nameController.text.trim(),
          pharmacistName: _pharmacistController.text.trim(),
          address: _addressController.text.trim(),
          openTime: _openTime,
          closeTime: _closeTime,
          isOpen: _isOpen,
        ),
      );
      if (mounted) Navigator.of(context).maybePop();
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'ص' : 'م';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBg,
        appBar: _buildAppBar(context),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                children: [
                  const _AvatarPicker(),
                  const SizedBox(height: 20),
                  _SectionCard(
                    title: 'بيانات الصيدلية',
                    child: Column(
                      children: [
                        _LabeledField(
                          label: 'اسم الصيدلية',
                          controller: _nameController,
                          icon: Icons.storefront_outlined,
                        ),
                        const SizedBox(height: 14),
                        _LabeledField(
                          label: 'اسم الصيدلاني',
                          controller: _pharmacistController,
                          icon: Icons.person_outline_rounded,
                        ),
                        const SizedBox(height: 14),
                        _LabeledField(
                          label: 'العنوان',
                          controller: _addressController,
                          icon: Icons.location_on_outlined,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _SectionCard(
                    title: 'مواعيد العمل',
                    child: Row(
                      children: [
                        Expanded(
                          child: _TimePickerField(
                            label: 'فتح',
                            value: _formatTime(_openTime),
                            onTap: () => _pickTime(isOpenTime: true),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _TimePickerField(
                            label: 'غلق',
                            value: _formatTime(_closeTime),
                            onTap: () => _pickTime(isOpenTime: false),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _SectionCard(
                    title: 'حالة الصيدلية',
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _isOpen ? 'الصيدلية مفتوحة الآن' : 'الصيدلية مغلقة الآن',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textDark,
                            ),
                          ),
                        ),
                        Switch(
                          value: _isOpen,
                          onChanged: (v) => setState(() => _isOpen = v),
                          activeColor: AppColors.primaryGreen,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  _SaveButton(saving: _saving, onPressed: _handleSave),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryGreen,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'تعديل بيانات الصيدلية',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: TextButton.icon(
        onPressed: () => Navigator.of(context).maybePop(),
        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 18),
        label: const Text('رجوع', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

/// -----------------------------------------------------------------------
/// Avatar with an edit-photo badge
/// -----------------------------------------------------------------------
class _AvatarPicker extends StatelessWidget {
  const _AvatarPicker();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 84,
            height: 84,
            decoration: const BoxDecoration(
              color: AppColors.lightGreenBg,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.local_pharmacy_rounded,
              color: AppColors.primaryGreen,
              size: 38,
            ),
          ),
          Positioned(
            bottom: -2,
            left: -2,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primaryGreen,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.scaffoldBg, width: 2),
              ),
              child: const Icon(
                Icons.camera_alt_rounded,
                color: Colors.white,
                size: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// -----------------------------------------------------------------------
/// Shared white rounded card with a title header
/// -----------------------------------------------------------------------
class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

/// -----------------------------------------------------------------------
/// Labeled text field used for name / pharmacist / address
/// -----------------------------------------------------------------------
class _LabeledField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final int maxLines;

  const _LabeledField({
    required this.label,
    required this.controller,
    required this.icon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(fontSize: 14, color: AppColors.textDark),
          validator: (value) =>
              (value == null || value.trim().isEmpty) ? 'مطلوب' : null,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 18, color: AppColors.textGrey),
            filled: true,
            fillColor: AppColors.scaffoldBg,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.borderGrey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.borderGrey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.primaryGreen),
            ),
          ),
        ),
      ],
    );
  }
}

/// -----------------------------------------------------------------------
/// Tappable field that opens a TimePicker
/// -----------------------------------------------------------------------
class _TimePickerField extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const _TimePickerField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.scaffoldBg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.borderGrey),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
                const Icon(Icons.access_time_rounded,
                    size: 16, color: AppColors.textGrey),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// -----------------------------------------------------------------------
/// Save button
/// -----------------------------------------------------------------------
class _SaveButton extends StatelessWidget {
  final bool saving;
  final VoidCallback onPressed;

  const _SaveButton({required this.saving, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: saving ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: saving
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Text(
                'حفظ التعديلات',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }
}

/// -----------------------------------------------------------------------
/// Example usage
/// -----------------------------------------------------------------------
void main() {
  runApp(const _DemoApp());
}

class _DemoApp extends StatelessWidget {
  const _DemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Cairo', useMaterial3: true),
      home: PharmacyEditScreen(
        initialName: 'صيدلية النور',
        initialPharmacistName: 'أحمد محمد علي',
        initialAddress: 'شارع الجمهورية، قرية بني سويف',
        initialOpenTime: const TimeOfDay(hour: 8, minute: 0),
        initialCloseTime: const TimeOfDay(hour: 23, minute: 0),
        initialIsOpen: true,
        onSave: (data) {
          // TODO: call your Supabase update / Cubit event here.
          debugPrint('Saving: ${data.name}, open=${data.isOpen}');
        },
      ),
    );
  }
}
