import 'package:flutter/material.dart';

class ClientCardScreen extends StatelessWidget {
  const ClientCardScreen({super.key});

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
