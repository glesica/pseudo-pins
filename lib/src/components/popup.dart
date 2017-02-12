import 'package:over_react/over_react.dart';

import 'package:pseudo_pins/src/actions.dart';
import 'package:pseudo_pins/src/components/header.dart';
import 'package:pseudo_pins/src/components/matcher_list.dart';
import 'package:pseudo_pins/src/components/toolbar.dart';
import 'package:pseudo_pins/src/store.dart';

@Factory()
UiFactory<PopupProps> Popup;

@Props()
class PopupProps extends FluxUiProps<PseudoActions, PseudoStore> {}

@Component()
class PopupComponent extends FluxUiComponent<PopupProps> {
  @override
  dynamic render() {
    return (Dom.div()..id = 'popup')(
      (Header()..actions = props.actions)(),
      (Toolbar()..actions = props.actions)(),
      (MatcherList()
        ..actions = props.actions
        ..matchers = props.store.tabMatchers)(),
    );
  }
}
