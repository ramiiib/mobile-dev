import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpContent extends StatelessWidget {
  const HelpContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE1DBDF),
        centerTitle: true,
        title: const Text("Help", style: TextStyle(color: Colors.black)),
      ),
      body: Container(
        color: const Color(0xFFE8E3E3),
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: const <Widget>[
            ListTile(
              title: Text(
                'Quick Links:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            QuickLinkTile(
              text: 'AskMQ',
              url: 'https://ask.mq.edu.au/',
            ),
            QuickLinkTile(
              text: 'iLearn',
              url: 'https://ilearn.mq.edu.au/',
            ),
            QuickLinkTile(
              text: 'eStudent',
              url: 'https://student1.mq.edu.au/',
            ),
            QuickLinkTile(
              text: 'Email Support',
              url:
                  'https://students.mq.edu.au/support/technology/systems/email',
            ),
            QuickLinkTile(
              text: 'Handbook',
              url: 'https://coursehandbook.mq.edu.au/',
            ),
            QuickLinkTile(
              text: 'Exam Timetables',
              url: 'https://iexams.mq.edu.au/',
            ),
            QuickLinkTile(
              text: 'IT Support',
              url: 'https://students.mq.edu.au/support/technology/service-desk',
            ),
            QuickLinkTile(
              text: 'Unit Guides',
              url: 'https://unitguides.mq.edu.au/',
            ),
          ],
        ),
      ),
    );
  }
}

class QuickLinkTile extends StatelessWidget {
  final String text;
  final String url;

  const QuickLinkTile({required this.text, required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.launch),
      onTap: () => _launchURL(context, url),
    );
  }

  Future<void> _launchURL(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not launch $url'),
        ),
      );
    }
  }
}
