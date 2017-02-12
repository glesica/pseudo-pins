import 'package:uuid/uuid.dart';
import 'package:w_common/json_serializable.dart';

final Uuid _uuid = new Uuid();

class TabMatcher implements JsonSerializable {
  final String id;
  final String ignorePrefix;
  final String pattern;

  TabMatcher.blank()
      : id = _uuid.v4(),
        ignorePrefix = '',
        pattern = '';

  TabMatcher.fromJson(Map json)
      : this.id = json['id'],
        this.ignorePrefix = json['ignorePrefix'],
        this.pattern = json['pattern'];

  TabMatcher.updated(TabMatcher matcher, {String pattern, String ignorePrefix})
      : this.id = matcher.id,
        this.ignorePrefix = ignorePrefix ?? matcher.ignorePrefix,
        this.pattern = pattern ?? matcher.pattern;

  bool get isBlank => pattern.trim() == '' && ignorePrefix.trim() == '';

  @override
  Map toJson() {
    return {
      'id': id,
      'ignorePrefix': ignorePrefix,
      'pattern': pattern,
    };
  }
}
