import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    /**
     * Banners never dynamically changed size based on screen size. So Ive made the screen scrollable so even
     * though banners might get cut off
     * on screen sizes like 2500x1600 (such as tablets), 
     * the user will still be able to scroll through and see both banners.
     */
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20),
          Center(
            child: Hero(
              tag: 'image',
              child: Image.asset(
                'images/mqlogo.png',
                width: 200,
                height: 200,
              ),
            ),
          ),
          const Banner(
            title: "Upcoming events",
            height: 250,
            bannerContent:
                "May 12th \n COMP3130 Deliverable-2 Due \n \n Week 13 \n Mobile Security Challenges",
          ),
          const Banner(
            title: "Next class",
            height: 190,
            bannerContent:
                "COMP3130 - Mobile Application Development \n Date: 16th Apr \n Time: 11:00am-1:00pm \n Place: 4 RPD, 111 Faculty PC Lab",
          ),
        ],
      ),
    );
  }
}

class Banner extends StatelessWidget {
  final String title;
  final double height;
  final String bannerContent;

  const Banner({
    super.key,
    required this.title,
    required this.height,
    required this.bannerContent,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          height: height,
          width: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            border: Border.all(
              color: const Color(0xFF76232F),
              width: 5,
            ),
          ),
          margin: const EdgeInsets.only(top: 35),
          padding: const EdgeInsets.only(top: 30),
          alignment: Alignment.center,
          child: Text(
            bannerContent,
            textAlign: TextAlign.center,
            style: GoogleFonts.workSans(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: const Color(0xFF76232F),
            ),
          ),
        ),
        Container(
          height: 50,
          width: 350,
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          decoration: BoxDecoration(
            color: const Color(0xFF76232F),
            borderRadius: BorderRadius.circular(50),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: GoogleFonts.workSans(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
