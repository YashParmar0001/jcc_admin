import 'package:flutter/material.dart';
import 'package:jcc_admin/common/widget/scroll_to_hide_widget.dart';

class ComplaintScreen extends StatelessWidget {
  const ComplaintScreen({
    super.key,
    required this.controller,
    required this.bottomNavKey,
  });

  final ScrollController controller;
  final GlobalKey<ScrollToHideWidgetState> bottomNavKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ComplaintScreen'),
      ),
      body: const Center(
        child: Text('ComplaintScreen'),
      ),
    );
  }
}
