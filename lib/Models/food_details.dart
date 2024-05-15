import 'package:deliverable_2/Models/cart_model.dart';
import 'package:deliverable_2/Models/food.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodDetailsScreen extends StatefulWidget {
  final Food product;

  const FoodDetailsScreen({super.key, required this.product});

  @override
  // ignore: library_private_types_in_public_api
  _FoodDetailsScreenState createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  String selectedSize = "Small";
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(widget.product.imagePath,
                height: 250, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.product.name,
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold)),
                  Text("\$${widget.product.price}",
                      style:
                          const TextStyle(fontSize: 24, color: Colors.black)),
                  const SizedBox(height: 10),
                  Text(widget.product.description,
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text("Calories: ${widget.product.calories} kcal",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 131, 131, 131))),
                  Text("Caffeine: ${widget.product.caffeine} mg",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 131, 131, 131))),
                  const SizedBox(height: 20),
                  if (widget.product.isCoffee) ...[
                    const Text("Size",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSizeButton("Small"),
                        _buildSizeButton("Medium"),
                        _buildSizeButton("Large"),
                      ],
                    ),
                  ],
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity -= 1;
                            });
                          }
                        },
                      ),
                      Text("$quantity", style: const TextStyle(fontSize: 24)),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          if (quantity < 10) {
                            setState(() {
                              quantity += 1;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      var cart = Provider.of<CartModel>(context, listen: false);
                      cart.addFood(widget.product, quantity, selectedSize);

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Successfully added to cart!")));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFF76232F),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("Add to Order",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeButton(String size) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedSize = size;
        });
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor:
            selectedSize == size ? Colors.red : const Color(0XFF76232F),
      ),
      child: Text(size),
    );
  }
}
