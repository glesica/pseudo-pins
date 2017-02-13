import 'dart:async';

import 'package:chrome/chrome_ext.dart' as chrome;

import 'package:pseudo_pins/src/chrome.dart';

// TODO: Break this up into 2-3 functions to faciliate testing.
Future<Null> sortTabs() async {
  var state = await chromeProxy.loadState();
  var tabs = await chromeProxy.getCurrentTabs();
  var sortedTabs = <chrome.Tab>[];
  for (var matcher in state.tabMatchers) {
    if (matcher.isBlank || !matcher.isEnabled) {
      continue;
    }

    var matchedTabs = <chrome.Tab>[];
    var patternRegex = new RegExp(matcher.pattern);
    var ignoreRegex = new RegExp(matcher.ignorePrefix);

    tabs.removeWhere((tab) {
      if (patternRegex.hasMatch(tab.url)) {
        matchedTabs.add(tab);
        return true;
      }
      return false;
    });

    matchedTabs.sort((leftTab, rightTab) {
      var leftTitle = leftTab.title.replaceFirst(ignoreRegex, '').trim();
      var rightTitle = rightTab.title.replaceFirst(ignoreRegex, '').trim();

      // We can't allow ties, so we sort first on title, then on ID,
      // then, finally, on current index. ID should only be the same
      // for special windows like apps and devtools.
      if (leftTitle.compareTo(rightTitle) == -1) {
        return -1;
      }
      if (leftTitle == rightTitle) {
        if (leftTab.id < rightTab.id) {
          return -1;
        }
        if (leftTab.id == rightTab.id) {
          if (leftTab.index < rightTab.index) {
            return -1;
          }
          if (leftTab.index > rightTab.index) {
            return 1;
          }
        }
        if (leftTab.id > rightTab.id) {
          return 1;
        }
      }
      if (leftTitle.compareTo(rightTitle) == 1) {
        return 1;
      }
    });

    sortedTabs.addAll(matchedTabs);
  }

  sortedTabs.addAll(tabs);
  await chromeProxy.applyTabOrder(sortedTabs);
}

void main() {
  chrome.tabs..onAttached.listen((_) {
    sortTabs();
  })..onCreated.listen((_) {
    sortTabs();
  })..onMoved.listen((_) {
    sortTabs();
  })..onUpdated.listen((_) {
    sortTabs();
  });
}