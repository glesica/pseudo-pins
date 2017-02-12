import 'package:over_react/over_react.dart';

import 'package:pseudo_pins/src/actions.dart';

@Factory()
UiFactory<HeaderProps> Header;

@Props()
class HeaderProps extends UiProps {
  PseudoActions actions;
}

@Component()
class HeaderComponent extends UiComponent<HeaderProps> {
  @override
  dynamic render() {
    return (Dom.div()..id = 'header')(
      (Dom.img()
        ..src = 'icons/icon19.png'
        ..id = 'header-icon')(),
      (Dom.span()..id = 'header-title')('Pseudo Pins'),
    );
  }
}
