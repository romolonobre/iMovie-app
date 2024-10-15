import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension WidgetExtensions on Widget {
  Widget paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      Padding(padding: EdgeInsets.only(top: top, left: left, right: right, bottom: bottom), child: this);

  Widget paddingAll(double value) => Padding(padding: EdgeInsets.all(value), child: this);

  Widget borderRadius(double radius) => ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        child: this,
      );
}

extension GetYear on String {
  String getYear() {
    return split("-").first;
  }
}

extension DateTimeFormatting on String {
  String getFullDate() {
    DateTime dateTime = DateTime.parse(this);
    return DateFormat('d MMMM yyyy').format(dateTime);
  }
}

extension GlobalKeyEnsureVisible on GlobalKey {
  void ensureVisible() {
    final keyContext = currentContext;
    if (keyContext != null) {
      Future.delayed(const Duration(milliseconds: 200)).then((_) {
        Scrollable.ensureVisible(keyContext, alignment: 0.7, duration: const Duration(milliseconds: 200));
      });
    }
  }
}
