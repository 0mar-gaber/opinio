// This file demonstrates how to use AppColors throughout your app
// You can delete this file - it's just for reference

import 'package:flutter/material.dart';
import 'app_colors.dart';

class ColorUsageExamples extends StatelessWidget {
  const ColorUsageExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cloud, // Use cloud for background
      appBar: AppBar(
        backgroundColor: AppColors.iris, // Primary brand color
        foregroundColor: AppColors.cloud, // Text color on iris
        title: Text(
          'Example',
          style: TextStyle(color: AppColors.cloud),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Example 1: Text Colors
            _buildTextExamples(),
            const SizedBox(height: 20),
            
            // Example 2: Buttons
            _buildButtonExamples(),
            const SizedBox(height: 20),
            
            // Example 3: Containers and Cards
            _buildContainerExamples(),
            const SizedBox(height: 20),
            
            // Example 4: Status Indicators
            _buildStatusExamples(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Heading Text',
          style: TextStyle(
            color: AppColors.textPrimary, // or AppColors.onyx
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Body Text',
          style: TextStyle(
            color: AppColors.textSecondary, // or AppColors.slate
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Helper/Subtle Text',
          style: TextStyle(
            color: AppColors.textTertiary, // or AppColors.lightSlate
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildButtonExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Primary Button (CTA)
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.iris, // Primary brand
            foregroundColor: AppColors.cloud,
          ),
          child: const Text('Primary Button'),
        ),
        const SizedBox(height: 8),
        
        // Success Button
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.evergreen, // Success/Secondary
            foregroundColor: AppColors.cloud,
          ),
          child: const Text('Success Button'),
        ),
        const SizedBox(height: 8),
        
        // Error/Alert Button
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.fuschia, // Error brand
            foregroundColor: AppColors.cloud,
          ),
          child: const Text('Error Button'),
        ),
      ],
    );
  }

  Widget _buildContainerExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Card with accent color
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cloud,
            border: Border.all(color: AppColors.dorian),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text('Card with border'),
        ),
        const SizedBox(height: 8),
        
        // Container with peach accent
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.peach, // Tertiary brand
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text('Accented Container'),
        ),
      ],
    );
  }

  Widget _buildStatusExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Success indicator
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.evergreen.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: AppColors.evergreen),
              const SizedBox(width: 8),
              Text('Success message', style: TextStyle(color: AppColors.evergreen)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        
        // Error indicator
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.fuschia.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Icon(Icons.error, color: AppColors.fuschia),
              const SizedBox(width: 8),
              Text('Error message', style: TextStyle(color: AppColors.fuschia)),
            ],
          ),
        ),
      ],
    );
  }
}
