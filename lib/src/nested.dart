import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/// A mixin on `Widget` which exposes a `cloneWithChild` method.
mixin Nestable on Widget {
  /// `cloneWithChild` takes a child `Widget` and must create a copy of itself with the new child.
  /// All values except child (including [Key]) should be preserved.
  Nestable cloneWithChild(Widget child);
}

/// [Nested] converts the [Nestable] list
/// into a tree of nested [Nestable] widgets.
/// As a result, the only advantage of using [Nested] is improved
/// readability due to the reduction in nesting and boilerplate.
class Nested extends StatelessWidget {
  /// The [Nestable] list which is converted into a tree of [Nestable] widgets.
  /// The tree of [Nestable] widgets is created in order meaning the first [Nestable]
  /// will be the top-most [Nestable] and the last [Nestable] will be a direct ancestor
  /// of the `child` [Widget].
  final List<Nestable> widgets;

  /// This [Widget] will be a direct descendent of the last [Nestable] in `widgets`.
  final Widget child;

  const Nested({
    Key key,
    @required this.widgets,
    @required this.child,
  })  : assert(widgets != null),
        assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget tree = child;
    for (final widget in widgets.reversed) {
      tree = widget.cloneWithChild(tree);
    }
    return tree;
  }
}
