import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:simple_attendances/views/helpers/gap.dart';
import 'package:simple_attendances/core/utility/enums.dart';
import 'package:simple_attendances/core/stores/signin/signin_store.dart';
import 'package:simple_attendances/views/widgets/keyboard_dismissed_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInStore signInStore = SignInStore();

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return KeyboardDismissedWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign In'),
          centerTitle: true,
        ),
        body: Center(
          child: Form(
            key: signInStore.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: _size.width * 0.8),
                  child: TextFormField(
                    controller: signInStore.nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if ((value?.trim().isEmpty ?? true)) {
                        return 'Please enter your name';
                      } else if (value!.trim().length < 3) {
                        return 'Name must be at least 3 characters';
                      }
                      return null;
                    },
                  ),
                ),
                tenPx,
                Observer(
                  builder: (context) {
                    switch (signInStore.viewState) {
                      case ViewState.initial:
                        return _signInButton();
                      case ViewState.loaded:
                        return _signInButton();
                      case ViewState.error:
                        return const Text('Error');
                      default:
                        return const UnconstrainedBox(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return ElevatedButton(
      child: const Text('Sign In'),
      onPressed: () => signInStore.signIn(
        signInStore.nameController.text,
        context,
      ),
    );
  }
}
