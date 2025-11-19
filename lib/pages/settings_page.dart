import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ayarlar')),
      body: Placeholder(
        strokeWidth: 5,
        child: Expanded(child: Center(child: Text('Weny'))),
      ),
    );
  }
}
