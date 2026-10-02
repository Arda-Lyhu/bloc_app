import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const AppText.h2('Checkout'),
      ),
      body: ResponsiveContainer(
        maxWidth: 700,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppText.title(
                'Shipping Address',
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.location_on_rounded,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          AppText.subtitle('Jane Doe',
                              fontWeight: FontWeight.bold),
                          SizedBox(height: 4),
                          AppText.caption(
                            '3 Newbridge Court, Chackbay, NY 11213, United States',
                            isMuted: true,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, size: 20),
                      onPressed: () => AppHaptics.selection(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const AppText.title(
                'Payment Method',
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: colorScheme.primary.withValues(alpha: 0.5),
                  ),
                ),
                child: ListTile(
                  leading: Icon(Icons.credit_card_rounded,
                      color: colorScheme.primary),
                  title: const AppText.subtitle('Mastercard **** 3947',
                      fontWeight: FontWeight.w600),
                  trailing: Icon(Icons.check_circle_rounded,
                      color: colorScheme.primary),
                ),
              ),
              const Spacer(),
              AppButton(
                label: 'SUBMIT ORDER',
                icon: const Icon(Icons.lock_outline_rounded, size: 20),
                onPressed: () async {
                  AppLoader.showOverlay(
                    context,
                    message: 'Processing payment...',
                    style: AppLoaderStyle.wave,
                  );
                  await Future.delayed(const Duration(milliseconds: 1500));
                  if (context.mounted) {
                    AppLoader.hide(context);
                    AppAlerts.showSuccess(
                        context, 'Order placed successfully! 🎉');
                    Navigator.pop(context);
                  }
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
