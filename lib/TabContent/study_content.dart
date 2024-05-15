import 'package:deliverable_2/TabContent/help_content.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudyContent extends StatelessWidget {
  const StudyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE1DBDF),
        centerTitle: true,
        title: const Text('Study', style: TextStyle(color: Colors.black)),
        elevation: 1,
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              NotesTile(),
              StudyGroupsTile(),
              MyCoursesTile(),
              ToDoTile(),
              ToDoList(),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFE1DBDF),
    );
  }
}

class ToDoTile extends StatelessWidget {
  const ToDoTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.assignment_turned_in, color: Color(0xFF76232F)),
      title: Text(
        'To-Do',
        style: GoogleFonts.workSans(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class NotesTile extends StatelessWidget {
  const NotesTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const Icon(Icons.note_add, color: Color(0xFF76232F)),
      title: Text(
        'Notes',
        style: GoogleFonts.workSans(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: const <Widget>[
        QuickLinkTile(
            text: "Flutter Documentation", url: "https://docs.flutter.dev/"),
        QuickLinkTile(
            text: "Figma Learn", url: "https://help.figma.com/hc/en-us"),
      ],
    );
  }
}

class StudyGroupsTile extends StatelessWidget {
  const StudyGroupsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const Icon(Icons.group, color: Color(0xFF76232F)),
      title: Text(
        'Study Groups',
        style: GoogleFonts.workSans(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class MyCoursesTile extends StatelessWidget {
  const MyCoursesTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const Icon(Icons.book, color: Color(0xFF76232F)),
      title: Text(
        'My Courses',
        style: GoogleFonts.workSans(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'COMP3100 – Distributed Systems\nCOMP3130 – Mobile Application Development\nCOMP2010 – Algorithms and Data Structures',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final List<String> _tasks = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _addTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _tasks.add(_controller.text);
        _controller.clear();
        _saveTasks();
      });
    }
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
      _saveTasks();
    });
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> loadedTasks = prefs.getStringList('tasks') ?? [];
    setState(() {
      _tasks.addAll(loadedTasks);
    });
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tasks', _tasks);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Add a new task',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (_) => _addTask(),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: _tasks.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_tasks[index]),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _removeTask(index),
              ),
            );
          },
        ),
      ],
    );
  }
}