import 'dart:async';

import 'package:chrome/chrome_ext.dart' as chrome;
import 'package:pseudo_pins/src/state.dart';
import 'package:w_common/disposable.dart';

import 'package:pseudo_pins/constants.dart';

final ChromeProxy chromeProxy = new BrowserProxy();

/// A proxy interface that provides everything needed to manipulate
/// tabs.
abstract class ChromeProxy {
  Stream<Null> get tabsChanged;

  Future<Null> applyTabOrder(Iterable<chrome.Tab> tabs);

  Future<List<chrome.Tab>> getCurrentTabs();

  Future<PseudoState> loadState();

  Future<Null> persistState(PseudoState state);
}

/// A proxy that calls out to the Chrome extension APIs.
class BrowserProxy extends Disposable implements ChromeProxy {
  final StreamController<Null> _tabsChangedController =
      new StreamController<Null>();

  BrowserProxy() {
    manageStreamController(_tabsChangedController);
  }

  @override
  Stream<Null> get tabsChanged => _tabsChangedController.stream;

  @override
  Future<Null> applyTabOrder(Iterable<chrome.Tab> tabs) async {
    // We can't move anything to the left of the pinned
    // tabs, so figure out how many there are, that is
    // our left-most target index.
    var targetIndex = tabs.where((tab) => tab.pinned).length;

    for (var tab in tabs.where((tab) => !tab.pinned)) {
      await chrome.tabs
          .move(tab.id, new chrome.TabsMoveParams(index: targetIndex++));
    }
  }

  @override
  Future<List<chrome.Tab>> getCurrentTabs() async {
    var tabs = await chrome.tabs
        .query(new chrome.TabsQueryParams(currentWindow: true));
    return tabs.toList();
  }

  @override
  Future<PseudoState> loadState() async {
    Map json = await chrome.storage.sync.get({stateKey: null});

    if (json == null) {
      return new PseudoState();
    }

    return new PseudoState.fromJson(json[stateKey]);
  }

  @override
  Future<Null> persistState(PseudoState state) async {
    await chrome.storage.sync.set({stateKey: state.toJson()});
  }
}

/// A proxy that does not require access to the Chrome extension APIs
/// and is therefore suitable for injection during unit testing.
class MockProxy extends Disposable implements ChromeProxy {
  Iterable<chrome.Tab> _currentTabs;

  PseudoState _persistedState;

  final StreamController<Null> tabsChangedController =
      new StreamController<Null>();

  MockProxy(this._currentTabs) {
    manageStreamController(tabsChangedController);
  }

  @override
  Stream<Null> get tabsChanged => tabsChangedController.stream;

  @override
  Future<Null> applyTabOrder(Iterable<chrome.Tab> tabs) {
    _currentTabs = tabs.toList();
    return new Future.value(null);
  }

  @override
  Future<List<chrome.Tab>> getCurrentTabs() {
    return new Future.value(_currentTabs);
  }

  @override
  Future<PseudoState> loadState() {
    var state = _persistedState ?? new PseudoState();
    return new Future.value(state);
  }

  @override
  Future<Null> persistState(PseudoState state) {
    _persistedState = state;
    return new Future.value(null);
  }
}
