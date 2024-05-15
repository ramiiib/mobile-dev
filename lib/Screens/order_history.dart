import 'package:flutter/material.dart';
import '../Models/shared_preferences.dart';
import 'package:intl/intl.dart';

class OrderHistoryScreen extends StatelessWidget {
  final SharedPreferencesService _prefsService = SharedPreferencesService();

  OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order History"),
        backgroundColor: const Color(0xFFE1DBDF),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _prefsService.getOrderHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No order history found."));
          }
          List<Map<String, dynamic>> orders = snapshot.data!;
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              var order = orders[index];
              DateTime dateTime = order['dateTime'];
              String formattedDate =
                  DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);

              return ListTile(
                title:
                    Text("Order Total: \$${order['total'].toStringAsFixed(2)}"),
                subtitle: Text("Date and Time: $formattedDate"),
              );
            },
          );
        },
      ),
      backgroundColor: const Color(0xFFE1DBDF),
    );
  }
}
