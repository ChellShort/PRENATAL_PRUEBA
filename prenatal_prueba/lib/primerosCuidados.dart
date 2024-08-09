import 'package:flutter/material.dart';

class PrimerosCuidados extends StatelessWidget {
  const PrimerosCuidados({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Primeros Cuidados'),
      ),
      body: const Center(
        child: Text('Primeros Cuidados'),
      ),
    );
  }
}