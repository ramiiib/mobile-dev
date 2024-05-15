import 'package:flutter/material.dart';

class MapContent extends StatelessWidget {
  const MapContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8E3E3),
        centerTitle: true,
        title: const Text("Campus Map", style: TextStyle(color: Colors.black)),
        elevation: 1,
      ),
      body: SafeArea(
        child: InteractiveViewer(
          minScale: 0.01,
          maxScale: 5.0,
          constrained: false,
          child: Image.asset('images/map.png', fit: BoxFit.contain),
        ),
      ),
    );
  }
}
