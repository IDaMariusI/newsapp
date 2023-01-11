import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:newsapp/src/pages/pages.dart';
import 'package:newsapp/src/services/services.dart';
import 'package:newsapp/src/theme/tema.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: myTheme,
        title: 'Material App',
        home: const TabsPage(),
      ),
    );
  }
}
