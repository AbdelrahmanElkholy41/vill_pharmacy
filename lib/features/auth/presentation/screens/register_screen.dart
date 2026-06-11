import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';

import '../../domain/user_entity.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/role_selector.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  UserRole _role = UserRole.customer;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  // Future<void> _submit() async {
  //   if (!_formKey.currentState!.validate()) return;
  //   await context.read<AuthProvider>().register(
  //         name: _nameCtrl.text.trim(),
  //         email: _emailCtrl.text.trim(),
  //         phone: _phoneCtrl.text.trim(),
  //         password: _passwordCtrl.text,
  //         role: _role,
  //       );
  //
  //   if (!mounted) return;
  //   final provider = context.read<AuthProvider>();
  //   if (provider.status == AuthStatus.error) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(provider.errorMessage ?? 'حدث خطأ'),
  //       backgroundColor: AppColors.danger,
  //       behavior: SnackBarBehavior.floating,
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //     ));
  //     provider.clearError();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
                child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const SizedBox(height: 32),
                              const Center(
                                child: AuthHeader(
                                  title: 'إنشاء حساب جديد',
                                  subtitle: 'انضم إلى صيدلية القرية',
                                ),
                              ),
                              const SizedBox(height: 28),
                              const Text('أنا...',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary)),
                              const SizedBox(height: 10),
                              RoleSelector(
                                selectedRole: _role,
                                onChanged: (r) => setState(() => _role = r),
                              ),
                              const SizedBox(height: 20),
                              AuthTextField(
                                label: 'الاسم الكامل',
                                hint: 'أحمد محمد',
                                controller: _nameCtrl,
                                prefixIcon: const Icon(Icons.person_outline,
                                    color: AppColors.textMuted, size: 20),
                              ),
                              const SizedBox(height: 16),
                              AuthTextField(
                                label: 'البريد الإلكتروني',
                                hint: 'example@email.com',
                                controller: _emailCtrl,
                                keyboardType: TextInputType.emailAddress,
                                prefixIcon: const Icon(Icons.email_outlined,
                                    color: AppColors.textMuted, size: 20),
                              ),
                              const SizedBox(height: 16),
                              AuthTextField(
                                label: 'رقم الهاتف',
                                hint: '01012345678',
                                controller: _phoneCtrl,
                                keyboardType: TextInputType.phone,
                                prefixIcon: const Icon(Icons.phone_outlined,
                                    color: AppColors.textMuted, size: 20),
                              ),
                              const SizedBox(height: 16),
                              AuthTextField(
                                label: 'كلمة المرور',
                                hint: '••••••••',
                                controller: _passwordCtrl,
                                isPassword: true,
                              ),
                              const SizedBox(height: 16),
                              AuthTextField(
                                label: 'تأكيد كلمة المرور',
                                hint: '••••••••',
                                controller: _confirmCtrl,
                                isPassword: true,
                              ),
                              const SizedBox(height: 28),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'إنشاء حساب',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => Login())),
                                    child: const Text('تسجيل الدخول',
                                        style: TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  const Text('لديك حساب بالفعل؟',
                                      style: TextStyle(
                                          color: AppColors.textSecondary)),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ]
                        )
                    )
                )
            )
        )
    );
  }
}
