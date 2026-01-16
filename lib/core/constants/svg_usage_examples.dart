// This file shows how to use SVG files EASILY using AppAssets
// You can delete this file - it's just for reference

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_assets.dart'; // Import the easy-to-use assets

class SvgUsageExamples extends StatelessWidget {
  const SvgUsageExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SVG Usage Examples')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Example 1: Basic usage (easiest way!)
            _buildBasicExample(),
            const SizedBox(height: 20),
            
            // Example 2: With size
            _buildSizedExample(),
            const SizedBox(height: 20),
            
            // Example 3: With color
            _buildColoredExample(),
            const SizedBox(height: 20),
            
            // Example 4: In buttons/containers
            _buildInWidgetsExample(),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicExample() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('1. Basic SVG (EASIEST WAY!):', 
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        AppAssets.logoBlueWidget(), // Just like this!
      ],
    );
  }

  Widget _buildSizedExample() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('2. SVG with size:', 
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        // Fixed size
        AppAssets.personWidget(width: 100, height: 100),
        const SizedBox(height: 8),
        // Responsive size using ScreenUtil
        AppAssets.passwordWidget(width: 80.w, height: 80.h),
      ],
    );
  }

  Widget _buildColoredExample() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('3. SVG with color:', 
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        AppAssets.personWidget(
          width: 50,
          height: 50,
          color: Colors.blue,
        ),
        const SizedBox(height: 8),
        AppAssets.femaleWidget(
          width: 50,
          height: 50,
          color: Colors.pink,
        ),
      ],
    );
  }

  Widget _buildInWidgetsExample() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('4. SVG in buttons/containers:', 
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        // In a button
        ElevatedButton.icon(
          onPressed: () {},
          icon: AppAssets.personWidget(width: 20, height: 20),
          label: const Text('Login'),
        ),
        const SizedBox(height: 8),
        // In a row
        Row(
          children: [
            AppAssets.logoWhiteWidget(width: 40, height: 40),
            const SizedBox(width: 12),
            const Text('Company Logo'),
          ],
        ),
      ],
    );
  }
}

/* ============================================
   🎉 EASY WAY TO USE SVGs - AppAssets
   ============================================

Just import and use:
import 'package:your_app/core/constants/app_assets.dart';

1. SIMPLE (no parameters):
   AppAssets.logoBlueWidget()
   AppAssets.logoWhiteWidget()
   AppAssets.personWidget()
   AppAssets.passwordWidget()

2. WITH SIZE:
   AppAssets.personWidget(width: 100, height: 100)
   AppAssets.passwordWidget(width: 80.w, height: 80.h)

3. WITH COLOR:
   AppAssets.femaleWidget(color: Colors.pink)
   AppAssets.maleWidget(color: Colors.blue)

4. ALL OPTIONS:
   AppAssets.logoBlueWidget(
     width: 100,
     height: 100,
     color: Colors.blue,
     fit: BoxFit.contain,
   )

5. IN A ROW/COLUMN:
   Row(
     children: [
       AppAssets.personWidget(width: 24, height: 24),
       SizedBox(width: 8),
       Text('Profile'),
     ],
   )

6. IN BUTTON:
   ElevatedButton.icon(
     onPressed: () {},
     icon: AppAssets.passwordWidget(width: 20, height: 20),
     label: Text('Login'),
   )

============================================
   ALL AVAILABLE METHODS:
============================================
- AppAssets.logoBlueWidget()
- AppAssets.logoWhiteWidget()
- AppAssets.personWidget()
- AppAssets.passwordWidget()
- AppAssets.femaleWidget()
- AppAssets.maleWidget()
- AppAssets.num2Widget()
- AppAssets.onboarding1Widget()
- AppAssets.onboarding2Widget()
- AppAssets.onboarding3Widget()

Each method accepts optional parameters:
- width: double?
- height: double?
- color: Color?
- fit: BoxFit? (default: BoxFit.contain)

============================================
   IF YOU NEED THE PATH (not widget):
============================================
Use the constants:
- AppAssets.logoBlue
- AppAssets.logoWhite
- AppAssets.person
- AppAssets.password
- etc.

Then use with SvgPicture.asset(AppAssets.logoBlue)

*/
