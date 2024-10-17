// ignore_for_file: annotate_overrides, overridden_fields

import 'dart:ui';

import 'package:flutter/widgets.dart';

/// {@template custom_rect_tween}
/// Linear RectTween with a [Curves.easeOut] curve.
///
/// Less dramatic that the regular [RectTween] used in [Hero] animations.
/// {@endtemplate}
class CustomRectTween extends RectTween {
  /// {@macro custom_rect_tween}
  final Rect begin;
  final Rect end;
  CustomRectTween({
    required this.begin,
    required this.end,
  }) : super(begin: begin, end: end);

  @override
  Rect lerp(double t) {
    final elasticCurveValue = Curves.easeOut.transform(t);

    return Rect.fromLTRB(
      lerpDouble(begin.left, end.left, elasticCurveValue)!,
      lerpDouble(begin.top, end.top, elasticCurveValue)!,
      lerpDouble(begin.right, end.right, elasticCurveValue)!,
      lerpDouble(begin.bottom, end.bottom, elasticCurveValue)!,
    );
  }
}
