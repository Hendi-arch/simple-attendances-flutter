import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:simple_attendances/app/routes.dart';
import 'package:simple_attendances/app/get_it_registry.dart';
import 'package:simple_attendances/core/utility/enums.dart';
import 'package:simple_attendances/core/stores/user/user_store.dart';
import 'package:simple_attendances/core/utility/navigator_utils.dart';
import 'package:simple_attendances/core/services/hive_db_service.dart';

part 'signin_store.g.dart';

class SignInStore = _SignInStoreBase with _$SignInStore;

abstract class _SignInStoreBase with Store, NavigatorMixin {
  final UserStore userStore = getIt<UserStore>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  @observable
  ObservableFuture<void>? _signInFuture;

  @computed
  ViewState get viewState => _signInFuture == null
      ? ViewState.initial
      : _signInFuture?.status == FutureStatus.pending
          ? ViewState.loading
          : _signInFuture?.status == FutureStatus.rejected
              ? ViewState.error
              : ViewState.loaded;

  @action
  Future<void> signIn(
    String name,
    BuildContext context,
  ) async {
    if (formKey.currentState!.validate()) {
      if (viewState == ViewState.loading) return;
      // Fake sign in
      _signInFuture = ObservableFuture<void>(Future.delayed(const Duration(milliseconds: 1500)));
      await _signInFuture;

      // Set user data
      userStore.setUserData(name, Localizations.maybeLocaleOf(context)?.languageCode);

      // Navigate to home
      removeCurrentAndGoNamed(route: Routes.home);
    }
  }
}
