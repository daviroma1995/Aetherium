import 'package:flutter/material.dart';

import 'controller.dart';

typedef ControllerBuilder<T> = Widget Function(T controller);

class Builder<T extends Controller> extends StatefulWidget {
  final ControllerBuilder<T> builder;
  final T? controller;
  final ThemeData? theme;

  final void Function(BuilderState<T> state)? initState,
      dispose,
      didChangeDependencies;
  final void Function(Builder oldWidget, BuilderState<T> state)?
      didUpdateWidget;

  const Builder({
    Key? key,
    required this.controller,
    required this.builder,
    this.initState,
    this.dispose,
    this.didChangeDependencies,
    this.didUpdateWidget,
    this.theme,
  }) : super(key: key);

  @override
  BuilderState<T> createState() => BuilderState<T>();
}

class BuilderState<T extends Controller>
    extends State<Builder<T>> //with GetStateUpdaterMixin
{
  T? controller;
  VoidCallback? _remove;

  @override
  void initState() {
    super.initState();
    widget.initState?.call(this);
    controller = widget.controller;
    controller?.state = this;
    controller?.theme = widget.theme;
    controller?.context = context;
    controller?.initState();
    _subscribeToController();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  /// Register to listen Controller's events.
  /// It gets a reference to the remove() callback, to delete the
  /// setState "link" from the Controller.
  void _subscribeToController() {
    _remove?.call();
    _remove = controller?.addListener(update);
  }

  void update() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    widget.dispose?.call(this);
    _remove?.call();
    _remove = null;
    controller?.dispose();
    controller = null;
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.didChangeDependencies?.call(this);
  }

  @override
  void didUpdateWidget(Builder oldWidget) {
    super.didUpdateWidget(oldWidget as Builder<T>);
    widget.didUpdateWidget?.call(oldWidget, this);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.theme != null) {
      return Theme(data: widget.theme!, child: widget.builder(controller!));
    }
    return widget.builder(controller!);
  }
}
