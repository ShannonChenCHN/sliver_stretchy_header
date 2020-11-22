import 'package:flutter/material.dart';

import 'render_object.dart';
import 'element.dart';

/// 带有背景和下拉拉伸效果的 header
///
///          /--------------/  --
///         /              /   /
///        /  background  /   /
///       /              /   /
///    /-------------/  /   /  stretchable
///   /    child    /  /   /
///  /             /  /   /
/// /-------------/  /   /
///  /--------------/  --
///
class SliverStretchHeader extends RenderObjectWidget {
  const SliverStretchHeader({
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

  /// 顶部空白处(可拉伸)的最小高度
  final double minBlankExtent;

  @override
  SliverStretchHeaderElement createElement() => SliverStretchHeaderElement(this);

  @override
  RenderSliverStretchHeader createRenderObject(BuildContext context) {
    return RenderSliverStretchHeader(
        minBlankExtent: minBlankExtent
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderSliverStretchHeader renderObject) {
    renderObject..minBlankExtent = minBlankExtent;
  }
}
