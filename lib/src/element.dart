import 'package:flutter/material.dart';

import 'render_object.dart';
import 'widget.dart';

/// 带有背景和下拉拉伸效果的 header
class SliverStretchHeaderElement extends RenderObjectElement {
  SliverStretchHeaderElement(SliverStretchHeader widget) : super(widget);

  @override
  SliverStretchHeader get widget => super.widget as SliverStretchHeader;

  Element _background;

  Element _child;

  @override
  void visitChildren(ElementVisitor visitor) {
    if (_child != null) {
      visitor(_child);
    }

    if (_background != null) {
      visitor(_background);
    }
  }

  @override
  void forgetChild(Element child) {
    if (child == _child) {
      _child = null;
      super.forgetChild(child);
    }

    if (child == _background) {
      _background = null;
      super.forgetChild(_background);
    }
  }

  @override
  void mount(Element parent, dynamic newSlot) {
    super.mount(parent, newSlot);
    _child = updateChild(_child, widget.child, 0);
    _background = updateChild(_background, widget.background, 1);
  }

  @override
  void update(SliverStretchHeader newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    _child = updateChild(_child, widget.child, 0);
    _background = updateChild(_background, widget.background, 1);
  }

  @override
  void insertRenderObjectChild(covariant RenderBox child, dynamic slot) {
    final RenderSliverStretchHeader renderObject = this.renderObject;
    if (slot == 0) renderObject.child = child;
    if (slot == 1) renderObject.background = child;
    assert(renderObject == this.renderObject);
  }

  @override
  void moveRenderObjectChild(covariant RenderObject child, dynamic oldSlot, dynamic newSlot) {
    assert(false);
  }

  @override
  void removeRenderObjectChild(covariant RenderObject child, dynamic slot) {
    final RenderSliverStretchHeader renderObject = this.renderObject;
    if (renderObject.child == child) renderObject.child = null;
    if (renderObject.background == child) renderObject.background = null;
    assert(renderObject == this.renderObject);
  }
}