import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Picker',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Colors'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<SharedPreferences> _prefs;
  late String _selectedColor;

  final Map<String, Color> _colorMap = {
    'red': Colors.red,
    'green': Colors.green,
    'blue': Colors.blue,
    'yellow': Colors.yellow,
    'purple': Colors.purple,
    'orange': Colors.orange,
  };

  Future<void> _changeColor(String color) async {
    final SharedPreferences prefs = await _prefs;

    await prefs.setString('color', color);
    setState(() {
      _selectedColor = color;
    });
  }

  @override
  void initState() {
    super.initState();
    _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      setState(() {
        _selectedColor = prefs.getString('color') ?? 'red';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _colorMap[_selectedColor],
        foregroundColor: Colors.white,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _colorMap.keys.map((color) {
            return Container(
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _colorMap[color],
                  fixedSize: const Size.fromHeight(80),
                ),
                onPressed: () => _changeColor(color),
                child: null,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
