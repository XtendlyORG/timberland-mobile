// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class OverflowWithHitTest extends SingleChildRenderObjectWidget {
  const OverflowWithHitTest({
    required this.overflowKeys,
    Widget? child,
    Key? key,
  }) : super(key: key, child: child);

  final List<GlobalKey> overflowKeys;

  @override
  _OverflowWithHitTestBox createRenderObject(BuildContext context) {
    return _OverflowWithHitTestBox(overflowKeys: overflowKeys);
  }

  @override
  void updateRenderObject(
      BuildContext context, _OverflowWithHitTestBox renderObject) {
    renderObject.overflowKeys = overflowKeys;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<List<GlobalKey>>('overflowKeys', overflowKeys));
  }
}

class _OverflowWithHitTestBox extends RenderProxyBoxWithHitTestBehavior {
  _OverflowWithHitTestBox({required List<GlobalKey> overflowKeys})
      : _overflowKeys = overflowKeys,
        super(behavior: HitTestBehavior.translucent);

  /// Global keys of overflow children
  List<GlobalKey> get overflowKeys => _overflowKeys;
  List<GlobalKey> _overflowKeys;

  set overflowKeys(List<GlobalKey> value) {
    var changed = false;

    if (value.length != _overflowKeys.length) {
      changed = true;
    } else {
      for (var ind = 0; ind < value.length; ind++) {
        if (value[ind] != _overflowKeys[ind]) {
          changed = true;
        }
      }
    }
    if (!changed) {
      return;
    }
    _overflowKeys = value;
    markNeedsPaint();
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (hitTestOverflowChildren(result, position: position)) {
      result.add(BoxHitTestEntry(this, position));
      return true;
    }
    bool hitTarget = false;
    if (size.contains(position)) {
      hitTarget =
          hitTestChildren(result, position: position) || hitTestSelf(position);
      if (hitTarget || behavior == HitTestBehavior.translucent) {
        result.add(BoxHitTestEntry(this, position));
      }
    }
    return hitTarget;
  }

  bool hitTestOverflowChildren(BoxHitTestResult result,
      {required Offset position}) {
    if (overflowKeys.isEmpty) {
      return false;
    }
    var hitGlobalPosition = localToGlobal(position);
    for (var child in overflowKeys) {
      if (child.currentContext == null) {
        continue;
      }
      var renderObj = child.currentContext!.findRenderObject();
      if (renderObj == null || renderObj is! RenderBox) {
        continue;
      }

      var localPosition = renderObj.globalToLocal(hitGlobalPosition);
      if (renderObj.hitTest(result, position: localPosition)) {
        return true;
      }
    }
    return false;
  }
}
