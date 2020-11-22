import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

/// 带有背景和下拉拉伸效果的 header
class RenderSliverStretchyHeader extends RenderSliver with RenderSliverHelpers {
  RenderSliverStretchyHeader({
    RenderBox child,
    RenderBox background,
    minBlankExtent = 0.0,
  }) {
    _minBlankExtent = minBlankExtent;
    this.child = child;
    this.background = background;
  }

  double get minBackgroundExtent => childExtent + minBlankExtent;
  bool get isStretching => scrollOffset <= 0;
  double get scrollOffset => constraints.scrollOffset + constraints.overlap;

  double get minBlankExtent => _minBlankExtent;
  double _minBlankExtent;
  set minBlankExtent(double value) {
    assert(value != null);
    if (_minBlankExtent == value) return;
    _minBlankExtent = value;
    markNeedsLayout();
  }

  double get childExtent {
    if (child == null) {
      return 0.0;
    }
    assert(child.hasSize);
    assert(constraints.axis == Axis.vertical);
    return child.size.height;
  }

  double get backgroundExtent {
    if (background == null) {
      return 0.0;
    }
    assert(background.hasSize);
    assert(constraints.axis == Axis.vertical);
    return background.size.height;
  }

  RenderBox get child => _child;
  RenderBox _child;
  set child(RenderBox value) {
    if (_child != null) dropChild(_child);
    _child = value;
    if (_child != null) adoptChild(_child);
  }

  RenderBox get background => _background;
  RenderBox _background;
  set background(RenderBox value) {
    if (_background != null) dropChild(_background);
    _background = value;
    if (_background != null) adoptChild(_background);
  }

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);
    if (_child != null) _child.attach(owner);
    if (_background != null) _background.attach(owner);
  }

  @override
  void detach() {
    super.detach();
    if (_child != null) _child.detach();
    if (_background != null) _background.detach();
  }

  @override
  void redepthChildren() {
    super.redepthChildren();
    if (_child != null) redepthChild(_child);
    if (_background != null) redepthChild(_background);
  }

  @override
  void visitChildren(void Function(RenderObject child) visitor) {
    super.visitChildren(visitor);
    if (_child != null) visitor(_child);
    if (_background != null) visitor(_background);
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    List<DiagnosticsNode> result = <DiagnosticsNode>[];
    if (child != null) {
      result.add(child.toDiagnosticsNode(name: 'child'));
    }
    if (background != null) {
      result.add(background.toDiagnosticsNode(name: 'background'));
    }
    return result;
  }

  @override
  void performLayout() {
    if (child == null || background == null) {
      geometry = SliverGeometry.zero;
      return;
    }

    // 计算 child 的布局
    child.layout(constraints.asBoxConstraints(), parentUsesSize: true);

    // 计算 background 的布局，在用户拖拽拉伸时强制 background 跟着拉伸
    double stretchOffset = 0.0;
    if (constraints.overlap < 0) {
      stretchOffset = constraints.overlap.abs();
    }
    final backgroundExtent = isStretching ? minBackgroundExtent + stretchOffset : minBackgroundExtent;
    background.layout(
      constraints.asBoxConstraints(
          maxExtent: backgroundExtent,
          minExtent: backgroundExtent
      ),
      parentUsesSize: true,
    );

    // 更新 geometry
    if (isStretching) {
      final double effectiveRemainingPaintExtent = math.max(0, constraints.remainingPaintExtent - constraints.overlap);
      final double layoutExtent = minBackgroundExtent.clamp(0.0, effectiveRemainingPaintExtent) - constraints.precedingScrollExtent;

      geometry = SliverGeometry(
        scrollExtent: backgroundExtent,
        paintOrigin: math.min(constraints.overlap, 0.0),
        paintExtent: math.min(backgroundExtent, effectiveRemainingPaintExtent),
        layoutExtent: math.max(layoutExtent, 0.0),
        maxPaintExtent: backgroundExtent,
        cacheExtent: backgroundExtent,
        maxScrollObstructionExtent: 0.0,
        hasVisualOverflow: true,
      );
    } else {
      final double paintedBackgroundSize = calculatePaintOffset(constraints, from: 0.0, to: backgroundExtent);
      final double cacheExtent = calculateCacheOffset(constraints, from: 0.0, to: backgroundExtent);
      final double layoutExtent = paintedBackgroundSize - constraints.precedingScrollExtent;

      assert(paintedBackgroundSize.isFinite);
      assert(paintedBackgroundSize >= 0.0);
      geometry = SliverGeometry(
        scrollExtent: backgroundExtent,
        paintExtent: paintedBackgroundSize,
        cacheExtent: cacheExtent,
        layoutExtent:math.max(layoutExtent, 0.0),
        maxPaintExtent: backgroundExtent,
        hitTestExtent: paintedBackgroundSize,
        hasVisualOverflow: backgroundExtent > constraints.remainingPaintExtent || scrollOffset > 0.0,
      );
    }

  }

  @override
  double childMainAxisPosition(covariant RenderObject child) {

    final double offset = isStretching ? 0 : -constraints.scrollOffset;
    final double originY = offset - constraints.precedingScrollExtent;
    if (child == this.background) {
      return originY;
    }

    if (child == this.child) {
      final double blankExtent = backgroundExtent - childExtent;
      return originY + blankExtent;
    }

    return 0.0;
  }

  @override
  bool hitTestChildren(SliverHitTestResult result, { @required double mainAxisPosition, @required double crossAxisPosition }) {
    assert(geometry.hitTestExtent > 0.0);
    // 按照绘制的层级从上往下一级一级传递
    if (child != null) {
      final bool isHit = hitTestBoxChild(
          BoxHitTestResult.wrap(result),
          child,
          mainAxisPosition: mainAxisPosition,
          crossAxisPosition: crossAxisPosition
      );
      if (isHit) return true;
    }

    if (background != null) {
      final bool isHit = hitTestBoxChild(
          BoxHitTestResult.wrap(result),
          background,
          mainAxisPosition: mainAxisPosition,
          crossAxisPosition: crossAxisPosition
      );
      if (isHit) return true;
    }

    return false;
  }

  @override
  double childScrollOffset(covariant RenderObject child) {
    assert(child.parent == this);
    if (child == this.child) {
      return backgroundExtent - childExtent;
    } else {
      return super.childScrollOffset(child);
    }
  }

  @override
  void applyPaintTransform(RenderObject child, Matrix4 transform) {
    assert(child != null);
    applyPaintTransformForBoxChild(child as RenderBox, transform);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (geometry.visible) {
      assert(constraints.axisDirection == AxisDirection.down);
      // 一定要保证先绘制 background
      if (background != null) {
        context.paintChild(background, offset + Offset(0.0, childMainAxisPosition(background)));
      }

      if (child != null) {
        context.paintChild(child, offset + Offset(0.0, childMainAxisPosition(child)));
      }
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty.lazy('minimum stretch extent', () => minBlankExtent));
    properties.add(DoubleProperty.lazy('child position', () => childMainAxisPosition(child)));
  }
}