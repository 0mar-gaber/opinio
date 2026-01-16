// This file demonstrates how to use AppTextStyles throughout your app
// You can delete this file - it's just for reference

import 'package:flutter/material.dart';
import 'app_text_styles.dart';
import 'app_colors.dart';

class TextStylesUsageExamples extends StatelessWidget {
  const TextStylesUsageExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Typography Examples', style: AppTextStyles.header3())),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title/Header 1
            Text('Title/Header 1', style: AppTextStyles.titleHeader1()),
            const SizedBox(height: 16),
            
            // Header 2
            Text('Header 2', style: AppTextStyles.header2()),
            const SizedBox(height: 16),
            
            // Header 3
            Text('Header 3', style: AppTextStyles.header3()),
            const SizedBox(height: 16),
            
            // Subtitle
            Text('Subtitle/Body Large', style: AppTextStyles.subtitle()),
            const SizedBox(height: 16),
            
            // Body Regular
            Text(
              'Body Regular - This is regular body text with proper line height for readability.',
              style: AppTextStyles.bodyRegular(),
            ),
            const SizedBox(height: 16),
            
            // Body Medium
            Text(
              'Body Medium - This is medium weight body text.',
              style: AppTextStyles.bodyMedium(),
            ),
            const SizedBox(height: 16),
            
            // Body Bold
            Text('Body Bold', style: AppTextStyles.bodyBold()),
            const SizedBox(height: 16),
            
            // Small
            Text('Small text', style: AppTextStyles.small()),
            const SizedBox(height: 16),
            
            // Pre Title
            Text('PRE TITLE', style: AppTextStyles.preTitle()),
            const SizedBox(height: 16),
            
            // Button Text
            ElevatedButton(
              onPressed: () {},
              child: Text('BUTTON TEXT', style: AppTextStyles.buttonText()),
            ),
            const SizedBox(height: 16),
            
            // Link
            Text('Link Text', style: AppTextStyles.link()),
          ],
        ),
      ),
    );
  }
}

/* ============================================
   📝 HOW TO USE AppTextStyles
   ============================================

1. Import:
   import 'package:your_app/core/constants/app_text_styles.dart';

2. Basic Usage:
   Text('Hello', style: AppTextStyles.header3())

3. With Custom Color:
   Text('Hello', style: AppTextStyles.header3(color: Colors.red))

4. With Custom Size:
   Text('Hello', style: AppTextStyles.bodyMedium(fontSize: 18.sp))

5. All Available Styles:
   - AppTextStyles.titleHeader1()  // Bold, 64px, -2% letter spacing
   - AppTextStyles.header2()       // Bold, 40px, -2% letter spacing
   - AppTextStyles.header3()       // Bold, 24px, -2% letter spacing
   - AppTextStyles.subtitle()      // Medium, 24px
   - AppTextStyles.bodyRegular()   // Regular, 15px, 140% line height
   - AppTextStyles.bodyMedium()    // Medium, 16px, 140% line height
   - AppTextStyles.bodyBold()      // Bold, 15px, 140% line height
   - AppTextStyles.small()         // Medium, 14px
   - AppTextStyles.preTitle()      // Bold, 10px, 3% letter spacing
   - AppTextStyles.buttonText()    // Bold, 10px, 3% letter spacing
   - AppTextStyles.link()          // Bold, 16px, underlined

6. Each method accepts optional parameters:
   - color: Color? (default uses AppColors)
   - fontSize: double? (default uses responsive size)

============================================ */
