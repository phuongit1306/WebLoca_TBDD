import 'package:flutter/material.dart';

class DashboardOfFragments extends StatefulWidget {

  @override
  State<DashboardOfFragments> createState() => _DashboardOfFragmentsState();
}

class _DashboardOfFragmentsState extends State<DashboardOfFragments> {
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
    );
  }
}
