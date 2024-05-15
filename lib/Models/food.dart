import 'package:deliverable_2/Models/food_details.dart';
import 'package:flutter/material.dart';

class Food extends StatelessWidget {
  final String name;
  final String description;
  final String price;
  final int calories;
  final int caffeine;
  final String imagePath;
  final bool isCoffee;

  const Food({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.calories,
    required this.caffeine,
    required this.isCoffee,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FoodDetailsScreen(
            product: this,
          ),
        ));
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Image.asset(imagePath, width: 100, height: 100),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(description,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black)),
                ],
              ),
            ),
            Text('\$$price',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
