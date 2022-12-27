import 'package:flutter/material.dart';

import 'controller_store.dart';
import 'disposable_interface.dart';
import 'listenable_mixin.dart';

abstract class Controller extends DisposableInterface
    with ListenableMixin, ListNotifierMixin {
  bool save = true;
  late BuildContext context;
  ThemeData? _theme;

  @protected
  late State _state;

  bool get mounted => _state.mounted;

  ThemeData get theme => _theme ?? Theme.of(context);

  set theme(ThemeData? theme) => _theme = theme;

  set state(State state) => _state = state;

  @protected
  void update() {
    changeState();
  }

  /// Implement [getTag] on child controller. Which return unique tag.
  String getTag();

  @override
  void dispose() {
    if (!save) {
      ControllerStore.delete(this);
      super.dispose();
    }
  }
}
