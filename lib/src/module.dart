import 'package:w_module/w_module.dart';

import 'package:pseudo_pins/src/actions.dart';
import 'package:pseudo_pins/src/components/popup.dart';
import 'package:pseudo_pins/src/store.dart';

class PseudoModule extends Module {
  PseudoActions _actions;
  PseudoApi _api;
  PseudoComponents _components;
  PseudoStore _store;

  PseudoModule({PseudoActions actions, PseudoStore store}) {
    _actions = actions ?? new PseudoActions();
    _store = store ?? new PseudoStore(_actions);
    _components = new PseudoComponents(_actions, _store);
    _api = new PseudoApi(_actions, _store);
  }

  @override
  PseudoApi get api => _api;

  @override
  PseudoComponents get components => _components;
}

class PseudoApi {
  PseudoActions _actions;
  PseudoStore _store;

  PseudoApi(this._actions, this._store);
}

class PseudoComponents extends ModuleComponents {
  final PseudoActions _actions;
  final PseudoStore _store;

  PseudoComponents(this._actions, this._store);

  @override
  dynamic content() => (Popup()
    ..actions = _actions
    ..store = _store)();
}
