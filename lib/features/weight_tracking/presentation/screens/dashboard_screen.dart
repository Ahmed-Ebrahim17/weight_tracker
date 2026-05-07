import 'package:flutter/material.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/dashboard_body.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: DashboardBody()));
  }
}
