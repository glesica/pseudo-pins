import 'package:over_react/over_react.dart';

import 'package:pseudo_pins/src/actions.dart';
import 'package:pseudo_pins/src/models.dart';
import 'package:pseudo_pins/src/components/matcher_item.dart';

@Factory()
UiFactory<MatcherListProps> MatcherList;

@Props()
class MatcherListProps extends UiProps {
  PseudoActions actions;
  Iterable<TabMatcher> matchers;
}

@Component()
class MatcherListComponent extends UiComponent<MatcherListProps> {
  @override
  Map getDefaultProps() => (newProps()..matchers = []);

  @override
  dynamic render() {
    if (props.matchers.isEmpty) {
      return (Dom.div()
        ..id = 'matchers-list'
        ..className = 'empty')((Dom.span())('No matchers.'));
    }

    final matcherItems = props.matchers.map((matcher) {
      return (MatcherItem()
        ..key = '${matcher.id}'
        ..actions = props.actions
        ..matcher = matcher)();
    });

    return (Dom.div()..id = 'matchers-list')(matcherItems);
  }
}
