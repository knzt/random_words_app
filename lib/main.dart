import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Random Words App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.light(
            primary: Color(0xFF18304C),
            onPrimary: Color(0xFFFFFFFF),
            background: Color(0xF2F2F2F2),
            secondary: Color(0xFFFFCBCB),
            onSecondary: Color(0xFFff914d),
          ),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigCard(pair: pair),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                appState.getNext();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
              ),
              child: Text('Próxima',
                  style: TextStyle(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.secondary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          pair.asLowerCase,
          style: TextStyle(
            color: theme.colorScheme.onPrimary,
            fontSize: 40.0,
          ),
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}
