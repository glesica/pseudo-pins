import 'package:w_common/json_serializable.dart';

import 'package:pseudo_pins/src/models.dart';

class PseudoState implements JsonSerializable {
  final Iterable<TabMatcher> tabMatchers;

  PseudoState({this.tabMatchers: const []});

  factory PseudoState.fromJson(Map json) {
    Iterable<Map> tabMatcherMaps = json['tabMatchers'] as Iterable<Map> ?? [];
    Iterable<TabMatcher> tabMatchers = tabMatcherMaps.map((matcherMap) {
      return new TabMatcher.fromJson(matcherMap);
    });
    return new PseudoState(tabMatchers: tabMatchers);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'tabMatchers': tabMatchers.map((matcher) => matcher.toJson()).toList(),
    };
  }
}
