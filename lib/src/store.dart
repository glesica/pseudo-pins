import 'dart:async';

import 'package:w_flux/w_flux.dart';

import 'package:pseudo_pins/src/actions.dart';
import 'package:pseudo_pins/src/chrome.dart';
import 'package:pseudo_pins/src/models.dart';
import 'package:pseudo_pins/src/state.dart';

class PseudoStore extends Store {
  final PseudoActions _actions;
  final List<TabMatcher> _tabMatchers = <TabMatcher>[];

  PseudoStore(this._actions) {
    triggerOnAction(_actions.addTabMatcher, _handleAddTabMatcher);
    triggerOnAction(_actions.removeTabMatcher, _handleRemoveTabMatcher);
    triggerOnAction(_actions.testTabMatcher, _handleTestTabMatcher);
    triggerOnAction(_actions.updateTabMatcher, _handleUpdateTabMatcher);
    _loadFromStorage();
  }

  Iterable<TabMatcher> get tabMatchers => _tabMatchers;

  PseudoState get state => new PseudoState(tabMatchers: _tabMatchers);

  @override
  void trigger() {
    _persistToStorage();
    super.trigger();
  }

  void _handleAddTabMatcher(TabMatcher matcher) {
    if (matcher == null) {
      _tabMatchers.add(new TabMatcher.blank());
    } else {
      _tabMatchers.add(matcher);
    }
  }

  void _handleRemoveTabMatcher(TabMatcher matcher) {
    _tabMatchers.remove(matcher);
  }

  void _handleTestTabMatcher(TabMatcher matcher) {
    // dispatch an event or whatever?
    // or maybe we actually generate results on our own?
    // yeah let's do that, present results as a list of tab titles / urls
  }

  void _handleUpdateTabMatcher(TabMatcher newMatcher) {
    TabMatcher oldMatcher =
        _tabMatchers.singleWhere((matcher) => matcher.id == newMatcher.id);
    int index = _tabMatchers.indexOf(oldMatcher);
    _tabMatchers.removeAt(index);
    _tabMatchers.insert(index, newMatcher);
  }

  Future<Null> _loadFromStorage() async {
    PseudoState state = await chromeProxy.loadState();

    for (TabMatcher matcher in state.tabMatchers) {
      _tabMatchers.add(matcher);
    }

    trigger();
  }

  Future<Null> _persistToStorage() async {
    await chromeProxy.persistState(state);
  }
}
