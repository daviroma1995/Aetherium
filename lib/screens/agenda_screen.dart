import 'package:flutter/material.dart';

class AgendaScreen extends StatelessWidget {
  const AgendaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('about'), backgroundColor: Colors.blue),
      body: const Center(
        child: Text('Agenda of this app...'),
      ),
    );
  }
}
