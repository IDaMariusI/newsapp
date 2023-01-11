import 'package:flutter/material.dart';

import 'package:newsapp/src/models/models.dart';

class NewsList extends StatelessWidget {
  const NewsList(this.news, {super.key});

  final List<Article> news;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(news[index].title ?? '');
      },
    );
  }
}
