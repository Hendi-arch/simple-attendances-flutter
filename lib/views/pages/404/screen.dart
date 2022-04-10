import 'package:flutter/material.dart';
import 'package:simple_attendances/views/widgets/custom_text_widget.dart';

class UnknownRouteScreen extends StatelessWidget {
  const UnknownRouteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CustomTextWidget(
          text: "Unknown Screen!",
        ),
      ),
    );
  }
}
