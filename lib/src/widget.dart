import 'package:flutter/material.dart';

import 'render_object.dart';
import 'element.dart';

/// 带有背景和下拉拉伸效果的 header
///
///          /--------------/  --
///         /              /   /
///        /  background  /   /  可拉伸区域
///       /              /   /
///    /-------------/  /   /
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
    this.minStretchExtent
  }) : assert(child != null),
        assert(background != null),
        super(key: key);

  /// 展示在最上层的内容，不可拉伸区域
  final Widget child;

  /// 展示在最底层的背景，会随着拉伸放大
  final Widget background;

  /// 可拉伸区域的最小高度
  final double minStretchExtent;

  @override
  SliverStretchHeaderElement createElement() => SliverStretchHeaderElement(this);

  @override
  RenderSliverStretchHeader createRenderObject(BuildContext context) {
    return RenderSliverStretchHeader(
      minStretchExtent: minStretchExtent
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderSliverStretchHeader renderObject) {
    renderObject..minStretchExtent = minStretchExtent;
  }
}
