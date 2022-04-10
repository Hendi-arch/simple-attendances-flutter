// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStoreBase, Store {
  final _$_startupFutureAtom = Atom(name: '_UserStoreBase._startupFuture');

  @override
  ObservableFuture<Box<dynamic>>? get _startupFuture {
    _$_startupFutureAtom.reportRead();
    return super._startupFuture;
  }

  @override
  set _startupFuture(ObservableFuture<Box<dynamic>>? value) {
    _$_startupFutureAtom.reportWrite(value, super._startupFuture, () {
      super._startupFuture = value;
    });
  }

  final _$_userBoxAtom = Atom(name: '_UserStoreBase._userBox');

  @override
  Box<dynamic>? get _userBox {
    _$_userBoxAtom.reportRead();
    return super._userBox;
  }

  @override
  set _userBox(Box<dynamic>? value) {
    _$_userBoxAtom.reportWrite(value, super._userBox, () {
      super._userBox = value;
    });
  }

  @override
  ObservableFuture<void> initUserBox() {
    final _$future = super.initUserBox();
    return ObservableFuture<void>(_$future);
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
