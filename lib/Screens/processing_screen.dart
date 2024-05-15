import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Models/cart_model.dart';

class OrderProcessingScreen extends StatefulWidget {
  final CartModel cart;
  const OrderProcessingScreen({super.key, required this.cart});

  @override
  // ignore: library_private_types_in_public_api
  _OrderProcessingScreenState createState() => _OrderProcessingScreenState();
}

class _OrderProcessingScreenState extends State<OrderProcessingScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 3), () {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      Future.microtask(() => orderSuccessful(context));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Processing your order',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              strokeWidth: 6,
            ),
            SizedBox(height: 20),
            Text(
              'We are finalising your order. Almost done!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Please don\'t close this screen',
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  void orderSuccessful(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.75,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Order Successful!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Thank you for ordering from esc Cafe! We’ve received your order, and it looks really good.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.cart.cart.length,
                  itemBuilder: (context, index) {
                    final item = widget.cart.cart[index];
                    String subtitleText =
                        '${item.quantity} x \$${item.food.price}';
                    if (item.food.isCoffee) {
                      subtitleText += ' - Size: ${item.size}';
                    }
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          item.food.imagePath,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(item.food.name),
                      subtitle: Text(subtitleText),
                      trailing: Text(
                        '\$${(item.quantity * double.parse(item.food.price)).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16, 
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Total: \$${widget.cart.total.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    widget.cart.clearCart();
                    Navigator.of(context).pop();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child:
                      const Text('OK', style: TextStyle(color: Colors.black)),
                ),
              ),
            ],
          ),
        );
      },
    ).whenComplete(() {
      widget.cart.clearCart();
    });
  }
}
