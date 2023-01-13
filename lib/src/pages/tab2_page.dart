import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:newsapp/src/models/models.dart';
import 'package:newsapp/src/services/services.dart';
import 'package:newsapp/src/theme/tema.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(child: _CategoriesList()),
          ],
        ),
      ),
    );
  }
}

class _CategoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        final cName = categories[index].name;

        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              _CategoryButton(categories[index]),
              const SizedBox(height: 5),
              Text('${cName[0].toUpperCase()}${cName.substring(1)}'),
            ],
          ),
        );
      },
    );
  }
}

class _CategoryButton extends StatelessWidget {
  const _CategoryButton(this.category);

  final Category category;

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = category.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          category.icon,
          color: (newsService.selectedCategory == category.name)
              ? myTheme.colorScheme.secondary
              : Colors.black54,
        ),
      ),
    );
  }
}
