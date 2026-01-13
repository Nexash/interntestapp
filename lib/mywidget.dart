import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final Widget child;
  final String? title;
  final bool includeAppBar;

  const BasePage({
    Key? key,
    required this.child,
    this.title,
    this.includeAppBar = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: includeAppBar && title != null
          ? AppBar(title: Text(title!))
          : null,
      body: SafeArea(
        child: child,
      ),
    );
  }
}
