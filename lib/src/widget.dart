import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'render_object.dart';
import 'element.dart';

/// 带有背景和下拉拉伸效果的 header
///
///          /--------------/ --  --
///         /              /  /   /
///        /  background  /  /----------->  blank extent
///       /              /  /   /
///    /-------------/  / --   /  stretchable
///   /    child    /  /      /
///  /             /  /      /
/// /-------------/  /      /
///  /--------------/     --
class SliverStretchyHeader extends RenderObjectWidget {
  const SliverStretchyHeader({
    Key key,
    this.child,
    this.background,
    this.minBlankExtent
  }) : assert(child != null),
        assert(background != null),
        super(key: key);

  /// 展示在最上层的内容，不可拉伸区域
  final Widget child;

  /// 展示在最底层的背景，会随着拉伸放大
  final Widget background;

  /// child 距离顶部的最小高度，也就是没有拉伸时的距离
  final double minBlankExtent;

  @override
  SliverStretchyHeaderElement createElement() => SliverStretchyHeaderElement(this);

  @override
  RenderSliverStretchyHeader createRenderObject(BuildContext context) {
    return RenderSliverStretchyHeader(
      minBlankExtent: minBlankExtent
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderSliverStretchyHeader renderObject) {
    renderObject..minBlankExtent = minBlankExtent;
  }
}
