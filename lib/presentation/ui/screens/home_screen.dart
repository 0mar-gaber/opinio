import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // or AppColors.cloud
      appBar: AppBar(
        backgroundColor: AppColors.iris, // Primary brand color
        foregroundColor: AppColors.cloud, // Text color on iris background
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Example: Primary text
            Text(
              'Welcome Home',
              style: TextStyle(
                color: AppColors.textPrimary, // or AppColors.onyx
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Example: Secondary text
            Text(
              'This is body text',
              style: TextStyle(
                color: AppColors.textSecondary, // or AppColors.slate
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 32),
            
            // Example: Primary button
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.iris, // Primary CTA color
                foregroundColor: AppColors.cloud,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text('Primary Button'),
            ),
          ],
        ),
      ),
    );
  }
}
