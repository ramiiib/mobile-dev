import 'package:deliverable_2/Models/food.dart';
import 'package:deliverable_2/Models/food_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/cart_model.dart';
import '../Screens/order_history.dart';
import '../Screens/processing_screen.dart';

class OrderContent extends StatefulWidget {
  const OrderContent({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OrderContentState createState() => _OrderContentState();
}

class _OrderContentState extends State<OrderContent> {
  final List<Food> foodMenu = [
    const Food(name: 'Latte', description: 'A classic coffee', price: '4.10', imagePath: 'images/latte.png', calories: 190, caffeine: 150, isCoffee: true),
    const Food(name: 'Espresso', description: 'Intense and velvety', price: '2.99', imagePath: 'images/espresso.png', calories: 15, caffeine: 64, isCoffee: true),
    const Food(name: 'Flat White', description: 'Rich and creamy', price: '4.00', imagePath: 'images/flat_white.png', calories: 170, caffeine: 130, isCoffee: true),
    const Food(name: 'Cappuccino', description: 'Perfectly foamed', price: '3.50', imagePath: 'images/cappuccino.png', calories: 150, caffeine: 130, isCoffee: true),
    const Food(name: 'Caramel Macchiato', description: 'Sweet caramel with a hint of vanilla', price: '4.25', imagePath: 'images/cm.png', calories: 250, caffeine: 150, isCoffee: true),
    const Food(name: 'Green Tea', description: 'Refreshing and healthy', price: '3.00', imagePath: 'images/green_tea.png', calories: 0, caffeine: 30, isCoffee: true),
    const Food(name: 'Herbal Tea', description: 'Soothing and aromatic', price: '3.25', imagePath: 'images/herbal_tea.png', calories: 0, caffeine: 0, isCoffee: true),
    const Food(name: 'Almond Croissant', description: 'Traditional french croissant', price: '5.20', imagePath: 'images/ac.png', calories: 410, caffeine: 0, isCoffee: false),
    const Food(name: 'Danish Pastry', description: 'Raspberry or custard', price: '4.50', imagePath: 'images/danish.png', calories: 300, caffeine: 0, isCoffee: false),
    const Food(name: 'Blueberry Muffin', description: 'Fresh blueberries used', price: '2.75', imagePath: 'images/bm.png', calories: 360, caffeine: 0, isCoffee: false),
    const Food(name: 'Chocolate Croissant', description: 'Rich chocolate in a flaky pastry', price: '4.75', imagePath: 'images/chocolate_croissant.png', calories: 420, caffeine: 0, isCoffee: false),
    const Food(name: 'Vegetable Panini', description: 'Grilled vegetables on artisan bread', price: '5.50', imagePath: 'images/vp.png', calories: 400, caffeine: 0, isCoffee: false),
    const Food(name: 'Club Sandwich', description: 'Layered with turkey and veggies', price: '7.75', imagePath: 'images/cs.png', calories: 550, caffeine: 0, isCoffee: false),
    const Food(name: 'Cheese Cake', description: 'Creamy New York style', price: '4.95', imagePath: 'images/cc.png', calories: 430, caffeine: 0, isCoffee: false),
  ];

  List<Food> filteredMenu = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredMenu = foodMenu;
    searchController.addListener(_filterMenu);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _filterMenu() {
    String query = searchController.text.toLowerCase();
    List<Food> tempFood = foodMenu.where((product) {
      return product.name.toLowerCase().contains(query) ||
          product.description.toLowerCase().contains(query);
    }).toList();
    setState(() {
      filteredMenu = tempFood;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8E3E3),
        centerTitle: true,
        title: const Text("Order", style: TextStyle(color: Colors.black)),
        leading: const OrderHistoryButton(),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.black),
                onPressed: () => showCart(context),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Consumer<CartModel>(
                    builder: (_, cart, __) => Text(
                      cart.cart.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
        elevation: 1,
      ),
      body: Container(
        color: const Color(0xFFE8E3E3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  labelText: "I'm looking for...",
                  suffixIcon: Icon(Icons.search, color: Colors.red),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredMenu.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () => _showFoodDetails(context, filteredMenu[index]),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Image.asset(filteredMenu[index].imagePath,
                            width: 100, height: 100),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(filteredMenu[index].name,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Text(filteredMenu[index].description,
                                  style: const TextStyle(fontSize: 16)),
                              Text("\$${filteredMenu[index].price}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Note: All food and drink items are supplied from esc Café.",
                style: TextStyle(
                    fontSize: 16, color: Color.fromARGB(255, 131, 131, 131)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFoodDetails(BuildContext context, Food product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: FoodDetailsScreen(product: product),
        );
      },
    );
  }

  void showCart(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Consumer<CartModel>(
            builder: (context, cart, child) {
              return Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                    itemCount: cart.cart.length,
                    itemBuilder: (context, index) {
                      var item = cart.cart[index];
                      double totalPrice =
                          double.parse(item.food.price) * item.quantity;
                      String subtitleText = 'Qty: ${item.quantity}';
                      if (item.food.isCoffee) {
                        subtitleText += ', Size: ${item.size}';
                      }
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              item.food.imagePath,
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                              '${item.food.name} - \$${totalPrice.toStringAsFixed(2)}'),
                          subtitle: Text(subtitleText),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              Provider.of<CartModel>(context, listen: false)
                                  .removeItem(index);
                            },
                          ),
                        ),
                      );
                    },
                  )),
                  const ListTile(
                    title: Text('Request utensils, etc.',
                        style: TextStyle(color: Colors.black54)),
                    trailing: Icon(Icons.check_box),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('\$${cart.total.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: () async {
                        try {
                          await Provider.of<CartModel>(context, listen: false)
                              .checkout();
                          Navigator.pushReplacement(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderProcessingScreen(
                                    cart: Provider.of<CartModel>(context,
                                        listen: false))),
                          );
                        } catch (e) {
                          showDialog(
                            // ignore: use_build_context_synchronously
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Oops!'),
                              content: Text(e.toString()),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      child: const Text('Check Out',
                          style:
                              TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  )
                ],
              );
            },
          ),
        );
      }
    );
  }
}

class OrderHistoryButton extends StatelessWidget {
  const OrderHistoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.history),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => OrderHistoryScreen()),
        );
      },
    );
  }
}
