import 'package:flutter/material.dart';
import 'categories_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            // Image asset with error handling
            Image.asset(
              'assets/image1.png',
              width: 400,
              height: 400,
              errorBuilder: (context, error, stackTrace) {
                return const Text('Image failed to load');
              },
            ),
            const SizedBox(height: 0),
            ElevatedButton(
              onPressed: () {
                // Navigate to CategoriesPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoriesPage(),
                  ),
                );
              },
              child: const Text(
                'Get Started',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
