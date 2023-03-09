import 'package:flutter/material.dart';

class TreatmentsScreen extends StatelessWidget {
  const TreatmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('about'), backgroundColor: Colors.blue),
      body: const Center(
        child: Text('Guidelines of this app...'),
      ),
    );
  }
}
