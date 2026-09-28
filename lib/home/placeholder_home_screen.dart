import 'package:flutter/material.dart';

class PlaceholderHomeScreen extends StatelessWidget {
  const PlaceholderHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 48, 28, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ACCESS',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.check_rounded,
                size: 34,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 18),
              Text(
                'Authentication successful',
                style: theme.textTheme.displaySmall,
              ),
              const SizedBox(height: 12),
              Text(
                'Project home will be added here once the final app is locked.',
                style: theme.textTheme.bodyMedium,
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
