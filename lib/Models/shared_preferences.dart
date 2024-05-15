import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<void> saveOrder(double total) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList('orderHistory') ?? [];
    String newOrder = '$total,${DateTime.now().toIso8601String()}';
    history.add(newOrder);
    bool result = await prefs.setStringList('orderHistory', history);
    if (!result) {
      throw Exception("Failed to save order history");
    }
  }

  Future<List<Map<String, dynamic>>> getOrderHistory() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList('orderHistory') ?? [];
    if (history.isEmpty) {
      return [];
    }
    return history.map((order) {
      final parts = order.split(',');
      return {
        'total': double.tryParse(parts[0]) ?? 0.0,
        'dateTime': DateTime.tryParse(parts[1]) ?? DateTime.now(),
      };
    }).toList();
  }
}
