import 'package:flutter/material.dart';

class Neighbourhood extends StatefulWidget {
  const Neighbourhood({Key? key}) : super(key: key);

  @override
  State<Neighbourhood> createState() => _NeighbourhoodState();
}

class _NeighbourhoodState extends State<Neighbourhood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Neighbourhood")
        ),
      body: const Center(
        child: Text('Welcome to the Neighbourhood!'),
      ),
    );
  }
}