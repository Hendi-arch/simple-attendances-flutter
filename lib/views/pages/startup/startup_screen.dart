import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:simple_attendances/core/utility/enums.dart';
import 'package:simple_attendances/core/utility/navigator_utils.dart';
import 'package:simple_attendances/core/stores/startup/startup_store.dart';
import 'package:simple_attendances/core/utility/after_first_layout_mixin.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({Key? key}) : super(key: key);

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> with AfterFirstLayoutMixin, NavigatorMixin {
  final StartupStore startupStore = StartupStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Observer(
          builder: (context) {
            switch (startupStore.viewState) {
              case ViewState.initial:
                return const CircularProgressIndicator();
              case ViewState.loading:
                return const CircularProgressIndicator();
              case ViewState.loaded:
                return const Text('StartupScreen');
              case ViewState.error:
                return const Text('Error');
            }
          },
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    startupStore.handleStartup();
  }
}
