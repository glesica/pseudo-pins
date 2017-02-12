import 'package:w_flux/w_flux.dart';

import 'package:pseudo_pins/src/models.dart';

class PseudoActions {
  Action<TabMatcher> addTabMatcher = new Action<TabMatcher>();
  Action<TabMatcher> removeTabMatcher = new Action<TabMatcher>();
  Action<TabMatcher> testTabMatcher = new Action<TabMatcher>();
  Action<TabMatcher> updateTabMatcher = new Action<TabMatcher>();
}
