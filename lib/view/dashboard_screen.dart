import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(Object context) {
    return const Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Dashboard Screen',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
    );
  }
}