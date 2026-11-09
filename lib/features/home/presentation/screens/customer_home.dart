import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'package:pharmacy_app/core/helpers/extensions.dart';
import 'package:pharmacy_app/features/auth/domain/entities/user_entity.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theme/orders_palette.dart';
import '../cubit/pharmacy_near_cubit.dart';
import '../cubit/pharmacy_near_state.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/header.dart';
import '../widgets/order_buttom.dart';
import '../widgets/parmacy_card.dart';

class CustomerHomeScreen extends StatefulWidget {
  final VoidCallback onDashboard;
  final VoidCallback onNewOrder;
  final VoidCallback onTrack;
  final UserRole userRole;

  const CustomerHomeScreen({
    super.key,
    required this.onDashboard,
    required this.onNewOrder,
    required this.onTrack,
    required this.userRole,
  });

  @override
  State<CustomerHomeScreen> createState() => _PharmacyHomeScreenState();
}

class _PharmacyHomeScreenState extends State<CustomerHomeScreen> {
  bool _isGettingLocation = false;
  bool _locationServiceDisabled = false;
  bool _permissionPermanentlyDenied = false;
  String? _locationMessage;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    if (_isGettingLocation) return;

    setState(() {
      _isGettingLocation = true;
      _locationMessage = null;
      _locationServiceDisabled = false;
      _permissionPermanentlyDenied = false;
    });

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        _showLocationError(
          'خدمة الموقع غير مفعلة. من فضلك فعل الموقع من إعدادات الهاتف.',
          serviceDisabled: true,
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        _showLocationError(
          'نحتاج إلى صلاحية الموقع لعرض الصيدليات القريبة منك.',
        );
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        _showLocationError(
          'صلاحية الموقع مرفوضة نهائيًا. يمكنك تفعيلها من إعدادات التطبيق.',
          permanentlyDenied: true,
        );
        return;
      }

      final position = await Geolocator.getCurrentPosition();

      if (!mounted) return;

      await context.read<PharmacyNearCubit>().getNearbyPharmacies(
            position.latitude,
            position.longitude,
          );
    } on LocationServiceDisabledException {
      _showLocationError(
        'خدمة الموقع غير مفعلة. من فضلك فعل الموقع من إعدادات الهاتف.',
        serviceDisabled: true,
      );
    } on PermissionDeniedException {
      _showLocationError(
        'لم نتمكن من الوصول إلى موقعك. راجع صلاحيات التطبيق.',
      );
    } catch (_) {
      _showLocationError(
        'حدث خطأ أثناء تحديد موقعك. حاول مرة أخرى.',
      );
    } finally {
      if (mounted) {
        setState(() {
          _isGettingLocation = false;
        });
      }
    }
  }

  void _showLocationError(
    String message, {
    bool serviceDisabled = false,
    bool permanentlyDenied = false,
  }) {
    if (!mounted) return;

    setState(() {
      _locationMessage = message;
      _locationServiceDisabled = serviceDisabled;
      _permissionPermanentlyDenied = permanentlyDenied;
    });
  }

  Future<void> _openLocationSettings() async {
    if (_locationServiceDisabled) {
      await Geolocator.openLocationSettings();
    } else if (_permissionPermanentlyDenied) {
      await Geolocator.openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                context.pushNamed(Routes.UserProfile);
              },
              icon: const Icon(
                Icons.person_2_outlined,
                color: Colors.green,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFF0FDF4),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      const Header(),
                      const SizedBox(height: 28),
                      OrderButton(context: context),
                      const SizedBox(height: 32),
                      buildNearbySection(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              BottomNavBar(context: context,),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNearbySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'صيدليات قريبة منك',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111827),
              ),
            ),
            IconButton(
              tooltip: 'تحديث الصيدليات',
              onPressed: _isGettingLocation ? null : _getCurrentLocation,
              icon: _isGettingLocation
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(
                      Icons.refresh,
                      color: Colors.green,
                    ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (_locationMessage != null) _buildLocationError(),
        if (_isGettingLocation && _locationMessage == null)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: CircularProgressIndicator(),
            ),
          ),
        if (!_isGettingLocation && _locationMessage == null)
          BlocBuilder<PharmacyNearCubit, PharmacyNearState>(
            builder: (context, state) {
              if (state is PharmacyNearLoading) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (state is PharmacyNearSuccess) {
                final pharmacies = state.pharmacies;

                if (pharmacies.isEmpty) {
                  return _buildMessage(
                    'لا توجد صيدليات قريبة منك',
                  );
                }

                return Column(
                  children: pharmacies.map((pharmacy) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: PharmacyCard(
                        pharmacy: pharmacy,
                      ),
                    );
                  }).toList(),
                );
              }

              if (state is PharmacyNearError) {
                return _buildMessage(
                  state.message,
                  showRetry: true,
                );
              }

              return _buildMessage(
                'اضغط على تحديث لعرض الصيدليات القريبة منك',
              );
            },
          ),
      ],
    );
  }

  Widget _buildLocationError() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.location_off_outlined,
            color: Colors.orange,
            size: 32,
          ),
          const SizedBox(height: 10),
          Text(
            _locationMessage!,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _isGettingLocation
                ? null
                : _locationServiceDisabled || _permissionPermanentlyDenied
                    ? _openLocationSettings
                    : _getCurrentLocation,
            child: Text(
              _locationServiceDisabled || _permissionPermanentlyDenied
                  ? 'فتح الإعدادات'
                  : 'إعادة المحاولة',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(
    String message, {
    bool showRetry = false,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 14,
              ),
            ),
            if (showRetry)
              TextButton.icon(
                onPressed: _getCurrentLocation,
                icon: const Icon(Icons.refresh),
                label: const Text('إعادة المحاولة'),
              ),
          ],
        ),
      ),
    );
  }
}

