import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_app/core/helpers/extensions.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../user_profile/profile_screen.dart' hide AppColors;
import '../../data/models/pharmacy_modal.dart';
import '../Cubit/register_pharmacy_cubit.dart';
import '../Cubit/register_pharmacy_state.dart';
import '../widgets/pharmacy_data.dart';
import '../widgets/pharmacy_header.dart';
import '../widgets/setting_card.dart';
import '../widgets/state_pharmacu.dart';
import '../widgets/state_row.dart';

class PharmacyProfileScreen extends StatefulWidget {
  final VoidCallback? onLogout;

  const PharmacyProfileScreen({
    super.key,
    this.onLogout,
  });

  @override
  State<PharmacyProfileScreen> createState() => _PharmacyProfileScreenState();
}

class _PharmacyProfileScreenState extends State<PharmacyProfileScreen> {
  bool _newOrderNotifications = false;
  bool _vibrateOnNewOrder = false;
  bool _darkMode = false;

  @override
  void initState() {
    super.initState();

    // جلب بيانات الصيدلية
    context.read<PharmacyCubit>().getPharmacy();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<PharmacyCubit, PharmacyState>(
        listener: (context, state) {
          if (state is PharmacyError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFFEF4444),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.scaffoldBg,
            appBar: _buildAppBar(context),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    // Loading
                    if (state is PharmacyLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),

                    // Success
                    if (state is PharmacySuccess) ...[
                      PharmacyHeader(
                        pharmacy: state.pharmacy,
                      ),
                      const SizedBox(height: 16),
                      const SizedBox(height: 20),
                      PharmacyDataCard(
                        pharmacy: state.pharmacy,
                      ),
                      const SizedBox(height: 20),
                      SettingsCard(
                        newOrderNotifications: _newOrderNotifications,
                        vibrateOnNewOrder: _vibrateOnNewOrder,
                        darkMode: _darkMode,
                        pharmacyOpen: state.pharmacy.isOpen,
                        onNewOrderNotificationsChanged: (v) {
                          setState(() {
                            _newOrderNotifications = v;
                          });
                        },
                        onVibrateChanged: (v) {
                          setState(() {
                            _vibrateOnNewOrder = v;
                          });
                        },
                        onDarkModeChanged: (v) {
                          setState(() {
                            _darkMode = v;
                          });
                        },
                        onPharmacyOpenChanged: (v) {
                          context.read<PharmacyCubit>().pharmacyStatus(v);
                        },
                      ),
                    ],

                    const SizedBox(height: 24),

                    LogoutButton(),

                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryGreen,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'بروفايل الصيدلية',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: TextButton.icon(
        onPressed: () {
          Navigator.of(context).maybePop();
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 18,
        ),
        label: const Text(
          '',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),


    );
  }
}
