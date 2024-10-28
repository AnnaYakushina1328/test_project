import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkTheme = false;

  void toggleTheme() {
    setState(() {
      isDarkTheme = !isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Интерактивный проект',
      theme: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      home: MyHomePage(
        onToggleTheme: toggleTheme,
        isDarkTheme: isDarkTheme,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkTheme;

  const MyHomePage(
      {super.key, required this.onToggleTheme, required this.isDarkTheme});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List<String> quotes = [
    'Верь, что ты можешь, и ты уже на полпути к цели',
    'Действуй так, как будто то, что ты делаешь, имеет значение. Это действительно так',
    'Успех не окончательный, неудача не фатальна: главное - мужество продолжать.',
    'Единственное ограничение для нашего осознания завтрашнего дня - это наши сегодняшние сомнения',
    'Твоё время ограничено, так что не трать его впустую, живя чужой жизнью.'
  ];
  String displayText = 'Привет, Флаттер!';
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void changeText() {
    setState(() {
      displayText = quotes[Random().nextInt(quotes.length)];
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Интерактивный проект'),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkTheme ? Icons.dark_mode : Icons.light_mode),
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _animation.value),
                  child: child,
                );
              },
              child: Text(
                displayText,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: changeText,
              icon: const Icon(Icons.autorenew),
              label: const Text('Новая цитата'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
