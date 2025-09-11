import 'package:bmi_calculator/screens/info_screen.dart';
import 'package:bmi_calculator/vars/strings.dart';
import 'package:flutter/material.dart';

class MyScaffoldContainerBackground extends StatefulWidget {
  final Widget? child;
  final bool showAppBar;
  final bool showShadows; // This should be used for the splash screen

  const MyScaffoldContainerBackground({
    super.key,
    required this.child,
    this.showAppBar = false,
    this.showShadows = false,
  });

  @override
  State<MyScaffoldContainerBackground> createState() =>
      MyScaffoldContainerBackgroundState();
}

class MyScaffoldContainerBackgroundState
    extends State<MyScaffoldContainerBackground> {
  @override
  Widget build(BuildContext context) {
    // Depending on the widget configurations, we change what the appbar and containers are

    AppBar? bar;
    if (widget.showAppBar) {
      bar = AppBar(
        elevation: 1,
        shadowColor: Colors.grey,
        title: const Text(APP_NAME),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.info_outline_rounded,
              size: 36,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InfoScreen()),
              );
            },
          ),
        ],
      );
    }

    return Scaffold(
      appBar: bar,
      body: widget.child,
    );
  }
}
