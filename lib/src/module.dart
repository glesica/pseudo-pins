import 'package:pseudo_pins/src/actions.dart';
import 'package:pseudo_pins/src/components/popup.dart';
import 'package:pseudo_pins/src/store.dart';

class PseudoModule {
  PseudoActions _actions;
  PseudoComponents _components;
  PseudoStore _store;

  PseudoModule({PseudoActions actions, PseudoStore store}) {
    _actions = actions ?? new PseudoActions();
    _store = store ?? new PseudoStore(_actions);
    _components = new PseudoComponents(_actions, _store);
  }

  PseudoComponents get components => _components;
}

class PseudoComponents {
  final PseudoActions _actions;
  final PseudoStore _store;

  PseudoComponents(this._actions, this._store);

  dynamic content() => (Popup()
    ..actions = _actions
    ..store = _store)();
}
