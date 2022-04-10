import 'package:flutter/material.dart';
import 'package:simple_attendances/core/utility/navigator_utils.dart';
import 'package:simple_attendances/core/extensions/logger_extension.dart';
import 'package:simple_attendances/views/widgets/custom_text_widget.dart';

class DialogHelper with NavigatorMixin {
  Future<bool> confirmationDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) async {
    try {
      final bool? result = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: const Text('YES'),
                onPressed: () {
                  back(result: true);
                },
              ),
              TextButton(
                child: const Text('NO'),
                onPressed: () {
                  back(result: false);
                },
              ),
            ],
          );
        },
      );

      return result ?? false;
    } catch (e) {
      e.toString().logger();
      rethrow;
    }
  }

  // Show simple snackbar with a message.
  Future<void> snackBar({
    required String message,
  }) async {
    try {
      AppNavigatorKey.scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: CustomTextWidget(text: message)),
      );
    } catch (e) {
      e.toString().logger();
      rethrow;
    }
  }
}
