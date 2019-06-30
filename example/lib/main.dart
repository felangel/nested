import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

void main() => runApp(MyApp());

class NestableContainer extends StatelessWidget with Nestable {
  final String value;
  final Widget child;

  NestableContainer({
    Key key,
    @required this.value,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(value),
        child,
      ],
    );
  }

  @override
  Nestable cloneWithChild(Widget child) {
    return NestableContainer(
      key: key,
      value: value,
      child: child,
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('Nested Example')),
        body: Nested(
          widgets: [
            NestableContainer(value: '0'),
            NestableContainer(value: '1'),
            NestableContainer(value: '2'),
            NestableContainer(value: '3'),
          ],
          child: Text('4'),
        ),
      ),
    );
  }
}
