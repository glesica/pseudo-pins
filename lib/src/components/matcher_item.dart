import 'package:over_react/over_react.dart';
import 'package:react/react.dart' show SyntheticFormEvent, SyntheticMouseEvent;

import 'package:pseudo_pins/src/actions.dart';
import 'package:pseudo_pins/src/models.dart';

@Factory()
UiFactory<MatcherItemProps> MatcherItem;

@Props()
class MatcherItemProps extends UiProps {
  PseudoActions actions;
  TabMatcher matcher;
}

@State()
class MatcherItemState extends UiState {
  String pattern;
  String ignorePrefix;
  bool isEnabled;
}

@Component()
class MatcherItemComponent
    extends UiStatefulComponent<MatcherItemProps, MatcherItemState> {
  @override
  Map getInitialState() {
    return (newState()
      ..pattern = props.matcher.pattern
      ..ignorePrefix = props.matcher.ignorePrefix
      ..isEnabled = props.matcher.isEnabled);
  }

  @override
  dynamic render() {
    return (Dom.div()
      ..key = props.matcher.id
      ..className = 'matcher-item')(
        _patternField(), _ignorePrefixField(), _matcherControls());
  }

  dynamic _enabledButton() {
    var label = props.matcher.isEnabled ? 'Disable' : 'Enable';
    return (Dom.button()
      ..key = 'button-enabled'
      ..onClick = (SyntheticMouseEvent event) {
        final updatedMatcher = new TabMatcher.updated(props.matcher,
            isEnabled: !props.matcher.isEnabled);
        setState(newState()..isEnabled = updatedMatcher.isEnabled);
        props.actions.updateTabMatcher(updatedMatcher);
      })(label);
  }

  dynamic _patternField() {
    return (Dom.input()
      ..key = 'pattern'
      ..value = state.pattern
      ..placeholder = 'URL pattern to match...'
      ..onChange = (SyntheticFormEvent event) {
        final updatedMatcher =
            new TabMatcher.updated(props.matcher, pattern: event.target.value);
        setState(newState()..pattern = updatedMatcher.pattern);
        props.actions.updateTabMatcher(updatedMatcher);
      })();
  }

  dynamic _ignorePrefixField() {
    return (Dom.input()
      ..key = 'ignore-prefix'
      ..value = state.ignorePrefix
      ..placeholder = 'Title prefix to ignore...'
      ..onChange = (SyntheticFormEvent event) {
        final updatedMatcher = new TabMatcher.updated(props.matcher,
            ignorePrefix: event.target.value);
        setState(newState()..ignorePrefix = updatedMatcher.ignorePrefix);
        props.actions.updateTabMatcher(updatedMatcher);
      })();
  }

  dynamic _matcherControls() {
    return (Dom.div()..key = 'controls')(_enabledButton(), _removeButton());
  }

  dynamic _removeButton() {
    return (Dom.button()
      ..key = 'button-remove'
      ..className = 'button-remove'
      ..onClick = (SyntheticMouseEvent event) {
        props.actions.removeTabMatcher(props.matcher);
      })('✕');
  }

  dynamic _testButton() {
    return (Dom.button()
      ..key = 'button-test'
      ..onClick = (SyntheticMouseEvent event) {
        props.actions.testTabMatcher(props.matcher);
      })('Test');
  }
}
