import 'package:flutter/material.dart';
import 'sample_item.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatelessWidget {
  const SampleItemListView({
    super.key,
    this.items = const [SampleItem(1), SampleItem(2), SampleItem(3)],
  });

  static const routeName = '/';

  final List<SampleItem> items;

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Scale factors for responsiveness
    final imageWidthFactor = screenWidth * 0.5;
    final smallImageWidthFactor = screenWidth * 0.05;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.black,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: screenHeight * 0.02),
            Image.asset(
              'assets/images/Ai.png',
              width:
                  imageWidthFactor, // Adjust dynamically based on screen width
              fit: BoxFit.contain,
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/images/magic.png',
                  width: smallImageWidthFactor, // Adjust dynamically
                  fit: BoxFit.contain,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/buddy.png',
                    width: screenWidth * 0.7, // Adjust dynamically
                    fit: BoxFit.contain,
                  ),
                ),
                Image.asset(
                  'assets/images/magic.png',
                  width: smallImageWidthFactor, // Adjust dynamically
                  fit: BoxFit.contain,
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: const Text(
                'How may I help you today!',
                style: TextStyle(
                  fontSize: 28, // Text remains readable across devices
                  color: Color(0xffffffff),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            SizedBox(
              width: double.infinity,
              height: screenHeight * 0.1,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/chat');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1,
                    vertical: screenHeight * 0.02,
                  ),
                ),
                child: const Text('Get Started'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
