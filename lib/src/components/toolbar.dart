import 'package:over_react/over_react.dart';
import 'package:react/react.dart' show SyntheticMouseEvent;

import 'package:pseudo_pins/src/actions.dart';

@Factory()
UiFactory<ToolbarProps> Toolbar;

@Props()
class ToolbarProps extends UiProps {
  PseudoActions actions;
}

@Component()
class ToolbarComponent extends UiComponent<ToolbarProps> {
  @override
  dynamic render() {
    return (Dom.div()..id = 'toolbar')(_newButton(), _helpButton());
  }

  dynamic _button(String title, dynamic clickHandler(SyntheticMouseEvent event),
      {bool special: false}) {
    return (Dom.button()
      ..id = 'button-${title.replaceAll(' ', '-').toLowerCase()}'
      ..className = special ? 'special' : ''
      ..onClick = clickHandler)(title);
  }

  dynamic _newButton() {
    return _button('New', (SyntheticMouseEvent event) {
      props.actions.addTabMatcher(null);
    }, special: true);
  }

  dynamic _helpButton() {
    return _button('Help', (SyntheticMouseEvent event) {
      // TODO: Implement a Help action and components.
      props.actions.addTabMatcher(null);
    });
  }
}
