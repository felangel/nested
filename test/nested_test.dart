import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

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
        appBar: AppBar(title: Text('Nest Example')),
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

void main() {
  group('nest', () {
    test('throws AssertionError when widgets is null', () {
      try {
        Nested(
          widgets: null,
          child: Container(),
        );
      } catch (error) {
        expect(error is AssertionError, true);
      }
    });

    test('throws AssertionError when child is null', () {
      try {
        Nested(
          widgets: [],
          child: null,
        );
      } catch (error) {
        expect(error is AssertionError, true);
      }
    });

    testWidgets('should render a nested tree of widgets',
        (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      expect(find.text('0'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
    });
  });
}
