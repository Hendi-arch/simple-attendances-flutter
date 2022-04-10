// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignInStore on _SignInStoreBase, Store {
  Computed<ViewState>? _$viewStateComputed;

  @override
  ViewState get viewState =>
      (_$viewStateComputed ??= Computed<ViewState>(() => super.viewState,
              name: '_SignInStoreBase.viewState'))
          .value;

  final _$_signInFutureAtom = Atom(name: '_SignInStoreBase._signInFuture');

  @override
  ObservableFuture<void>? get _signInFuture {
    _$_signInFutureAtom.reportRead();
    return super._signInFuture;
  }

  @override
  set _signInFuture(ObservableFuture<void>? value) {
    _$_signInFutureAtom.reportWrite(value, super._signInFuture, () {
      super._signInFuture = value;
    });
  }

  final _$signInAsyncAction = AsyncAction('_SignInStoreBase.signIn');

  @override
  Future<void> signIn(String name, BuildContext context) {
    return _$signInAsyncAction.run(() => super.signIn(name, context));
  }

  @override
  String toString() {
    return '''
viewState: ${viewState}
    ''';
  }
}
