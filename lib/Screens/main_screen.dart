import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../TabContent/order_content.dart';
import '../TabContent/home_content.dart';
import '../TabContent/study_content.dart';
import '../TabContent/map_content.dart';
import '../TabContent/help_content.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const OrderContent(),
    const StudyContent(),
    const MapContent(),
    const HelpContent(),
  ];

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 4) {
      return 'Staying up late? Take care! 🤗';
    } else if (hour < 12) {
      return 'Good Morning ☀️';
    } else if (hour < 17) {
      return 'Good Afternoon 🌅';
    } else if (hour < 21) {
      return 'Good Evening 🌃';
    } else {
      return 'Have a Good Night 😴';
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            const Icon(
              Icons.school_sharp,
              size: 30,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                greeting(),
                style: GoogleFonts.workSans(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFE8E3E3),
      ),
      backgroundColor: const Color(0xFFE8E3E3),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[200],
        selectedItemColor: const Color(0xFFd6001c),
        unselectedItemColor: Colors.black87,
        iconSize: 30,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.coffee),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Study',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: 'Help',
          ),
        ],
        showUnselectedLabels: false,
        showSelectedLabels: true,
      ),
    );
  }
}
