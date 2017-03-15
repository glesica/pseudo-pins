import 'dart:html';

import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart' as react_client;

import 'package:pseudo_pins/pseudo_pins.dart';

void main() {
  react_client.setClientConfiguration();
  final container = querySelector('#container');
  final pseudoModule = new PseudoModule();
  react_dom.render(pseudoModule.components.content(), container);
}
