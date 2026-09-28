import 'package:flutter/material.dart';

class PlaceholderHomeScreen extends StatelessWidget {
  const PlaceholderHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(
                "You're in.",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: -1,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'Authentication verified. The Campus Club home screen comes next.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
