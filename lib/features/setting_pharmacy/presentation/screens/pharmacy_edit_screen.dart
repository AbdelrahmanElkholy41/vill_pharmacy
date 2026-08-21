import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/models/pharmacy_modal.dart';
import '../Cubit/register_pharmacy_cubit.dart';
import '../Cubit/register_pharmacy_state.dart';
import '../widgets/Text_field.dart';
import '../widgets/save_buttom.dart';
import '../widgets/section_card.dart';

class PharmacyRegisterScreen extends StatefulWidget {
  const PharmacyRegisterScreen({
    super.key,
  });

  @override
  State<PharmacyRegisterScreen> createState() =>
      _PharmacyRegisterScreenState();
}

class _PharmacyRegisterScreenState
    extends State<PharmacyRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameArController = TextEditingController();
  final _nameEnController = TextEditingController();

  final _addressArController = TextEditingController();
  final _addressEnController = TextEditingController();

  final _areaController = TextEditingController();
  final _phoneController = TextEditingController();

  final _latController = TextEditingController();
  final _lngController = TextEditingController();

  @override
  void dispose() {
    _nameArController.dispose();
    _nameEnController.dispose();
    _addressArController.dispose();
    _addressEnController.dispose();
    _areaController.dispose();
    _phoneController.dispose();
    _latController.dispose();
    _lngController.dispose();

    super.dispose();
  }

  void _registerPharmacy() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final lat = double.tryParse(
      _latController.text.trim(),
    );

    final lng = double.tryParse(
      _lngController.text.trim(),
    );

    if (lat == null || lng == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('من فضلك أدخل Latitude و Longitude صحيحين'),
        ),
      );
      return;
    }

    final pharmacy = PharmacyModel(
      name: PharmacyLocalizedText(
        ar: _nameArController.text.trim(),
        en: _nameEnController.text.trim(),
      ),
      address: PharmacyLocalizedText(
        ar: _addressArController.text.trim(),
        en: _addressEnController.text.trim(),
      ),
      area: _areaController.text.trim(),
      phone: _phoneController.text.trim(),
      location: PharmacyLocation(
        lat: lat,
        lng: lng,
      ),
    );

    context.read<PharmacyCubit>().registerPharmacy(
      pharmacy,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<PharmacyCubit, PharmacyState>(
        listener: (context, state) {
          if (state is PharmacySuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'تم تسجيل الصيدلية بنجاح',
                ),
              ),
            );

            Navigator.of(context).pop();
          }

          if (state is PharmacyError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final saving = state is PharmacyLoading;

          return Scaffold(
            backgroundColor: AppColors.scaffoldBg,

            appBar: AppBar(
              backgroundColor: AppColors.primaryGreen,
              centerTitle: true,
              elevation: 0,
              title: const Text(
                'إضافة الصيدلية',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            body: SafeArea(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      const _AvatarPicker(),

                      const SizedBox(height: 20),

                      // بيانات الصيدلية
                      SectionCard(
                        title: 'بيانات الصيدلية',
                        child: Column(
                          children: [
                            LabeledField(
                              label: 'اسم الصيدلية بالعربي',
                              controller: _nameArController,
                              icon: Icons.storefront_outlined,
                            ),

                            const SizedBox(height: 14),

                            LabeledField(
                              label: 'اسم الصيدلية بالإنجليزي',
                              controller: _nameEnController,
                              icon: Icons.storefront_outlined,
                            ),

                            const SizedBox(height: 14),

                            LabeledField(
                              label: 'العنوان بالعربي',
                              controller: _addressArController,
                              icon: Icons.location_on_outlined,
                              maxLines: 2,
                            ),

                            const SizedBox(height: 14),

                            LabeledField(
                              label: 'العنوان بالإنجليزي',
                              controller: _addressEnController,
                              icon: Icons.location_on_outlined,
                              maxLines: 2,
                            ),

                            const SizedBox(height: 14),

                            LabeledField(
                              label: 'المنطقة',
                              controller: _areaController,
                              icon: Icons.map_outlined,
                            ),

                            const SizedBox(height: 14),

                            LabeledField(
                              label: 'رقم الهاتف',
                              controller: _phoneController,
                              icon: Icons.phone_outlined,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Location
                      SectionCard(
                        title: 'موقع الصيدلية',
                        child: Row(
                          children: [
                            Expanded(
                              child: LabeledField(
                                label: 'Latitude',
                                controller: _latController,
                                icon: Icons.location_on_outlined,
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: LabeledField(
                                label: 'Longitude',
                                controller: _lngController,
                                icon: Icons.location_on_outlined,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      SaveButton(
                        saving: saving,
                        onPressed: _registerPharmacy,
                      ),

                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

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
                border: Border.all(
                  color: AppColors.scaffoldBg,
                  width: 2,
                ),
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
