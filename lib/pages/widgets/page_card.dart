import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageCard extends StatelessWidget {
  final String path;
  final String label;
  final IconData icon;
  const PageCard({
    super.key,
    required this.path,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(path),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          child: ListTile(title: Text(label), trailing: Icon(icon)),
        ),
      ),
    );
  }
}
