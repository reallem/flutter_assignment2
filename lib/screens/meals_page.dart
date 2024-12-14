import 'package:flutter/material.dart';
import '../services/api_service.dart';

class MealsPage extends StatelessWidget {
  final String category;
  final ApiService apiService = ApiService();

  MealsPage({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          category,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: apiService.fetchMeals(category), // meals from the API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.data == null || (snapshot.data as List).isEmpty) {
            return const Center(
              child: Text('No meals found for this category.'),
            );
          } else {
            final meals = snapshot.data as List<dynamic>;
            return ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 20), // padding around cards
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 15), // space above the image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          meal['strMealThumb'], // API meal image
                          height: 140,
                          width: 140,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 10), // space below the image
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          meal['strMeal'], // Meal name from API
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15), // space below the text
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
