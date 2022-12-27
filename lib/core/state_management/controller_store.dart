import 'controller.dart';

class ControllerStore {
  static final Map<String, Controller> _controllers = {};
  static final List<String> _history = [];

  static T putOrFind<T extends Controller>(T controller,
      {String? tag, bool save = true}) {
    tag ??= controller.getTag();
    _history.add(tag);
    if (_controllers.containsKey(tag) && _controllers[tag] is T) {
      T controller = _controllers[tag] as T;
      controller.save = controller.save && save;
      return controller;
    }
    return put(controller, tag: tag, save: save);
  }

  static T put<T extends Controller>(T controller,
      {String? tag, bool save = true}) {
    tag ??= controller.getTag();
    _history.add(tag);
    _controllers[tag] = controller;
    controller.save = controller.save && save;

    return controller;
  }

  static void delete<T extends Controller>(T controller, {String? tag}) {
    tag ??= controller.getTag();
    _history.remove(tag);
    _controllers.remove(tag);
  }

  static T? pop<T extends Controller>({T? controller, String? tag}) {
    if (tag == null && controller == null) {
      return null;
    }
    tag = tag ?? controller?.getTag();
    _history.remove(tag);
    if (_controllers.containsKey(tag) && _controllers[tag] is T) {
      T controller = _controllers[tag] as T;
      _controllers.remove(tag);
      return controller;
    }
    return null;
  }

  static Controller? last() {
    if (_history.isNotEmpty) {
      return _controllers[_history.last];
    }
    return null;
  }

  static void resetStore() {
    _controllers.clear();
    _history.clear();
  }
}
