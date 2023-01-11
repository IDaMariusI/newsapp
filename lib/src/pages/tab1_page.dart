import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:newsapp/src/services/services.dart';
import 'package:newsapp/src/widgets/widgets.dart';

class Tab1Page extends StatelessWidget {
  const Tab1Page({super.key});

  @override
  Widget build(BuildContext context) {
    final headlines = Provider.of<NewsService>(context).headlines;

    return Scaffold(
      body: NewsList(headlines),
    );
  }
}
