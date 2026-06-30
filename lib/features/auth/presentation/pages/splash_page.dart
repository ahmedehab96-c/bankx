import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/usecase.dart';
import '../../../../core/widgets/bankx_logo.dart';
import '../../../auth/data/datasources/auth_local_data_source.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../security/domain/repositories/security_repository.dart';
import '../../../security/domain/usecases/security_usecases.dart';

/// Animated splash screen with BankX branding.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _footerController;
  late Animation<double> _footerFade;
  late Animation<Offset> _footerSlide;

  @override
  void initState() {
    super.initState();

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..forward();

    _footerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _footerFade = CurvedAnimation(
      parent: _footerController,
      curve: Curves.easeOut,
    );

    _footerSlide = Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _footerController,
            curve: Curves.easeOutCubic,
          ),
        );

    Future<void>.delayed(const Duration(milliseconds: 900), () {
      if (mounted) _footerController.forward();
    });

    _navigate();
  }

  Future<void> _navigate() async {
    await Future<void>.delayed(const Duration(milliseconds: 3200));
    if (!mounted) return;

    final hasSession = await getIt<AuthLocalDataSource>().hasSession();
    if (hasSession) {
      if (await getIt<SecurityRepository>().isBiometricEnabled()) {
        final result = await getIt<BiometricLoginUseCase>()(const NoParams());
        final ok = result.fold((_) => false, (value) => value);
        if (!ok) {
          if (mounted) context.goLogin();
          return;
        }
      }
      if (mounted) {
        context.read<AuthBloc>().add(const AuthSessionRestored());
        context.goHome();
      }
      return;
    }

    if (mounted) context.goOnboarding();
  }

  @override
  void dispose() {
    _progressController.dispose();
    _footerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: BankXLogoBackground(
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 3),
              const BankXLogo(size: 260, animate: true),
              const Spacer(flex: 2),
              SlideTransition(
                position: _footerSlide,
                child: FadeTransition(
                  opacity: _footerFade,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedBuilder(
                          animation: _progressController,
                          builder: (context, _) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: _progressController.value,
                                minHeight: 3,
                                backgroundColor: Colors.white.withValues(
                                  alpha: 0.08,
                                ),
                                valueColor: const AlwaysStoppedAnimation(
                                  AppColors.accentCyan,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'DIGITAL BANKING',
                          style: TextStyle(
                            fontSize: 11,
                            letterSpacing: 3.5,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withValues(alpha: 0.45),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
