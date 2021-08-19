import 'package:flutter/material.dart';
import 'page_widget.dart';
import 'dart:developer';

class Nav {
  const Nav._();

  /// {@macro Nav.goto}
  /// Nav.goto(context, HomePage());
  static Future<T?> goto<T>(BuildContext context, PageWidget page) {
    log('Navigator.push: ${page.pageName}');
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// {@macro Nav.pop}
  static void pop<T>(BuildContext context, [T? result]) {
    log('Navigator.pop: ${result?.toString() ?? ''}');
    return Navigator.pop(context, result);
  }

  /// {@macro Nav.replace}
  /// Nav.replace(context, (context) => HomePage());
  static Future<void> replace<T>(BuildContext context, PageWidget page) {
    log('Navigator.pushReplacement: ${page.pageName}');
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// {@macro Nav.gotoRoot}
  static void gotoRoot(BuildContext context) {
    return Navigator.of(context).popUntil((route) => route.isFirst);
  }

  /// {@macro Nav.snackBar}
  static void snackBar<T>(
    BuildContext context, {
    Widget? content,
    String? text,
    SnackBarBehavior? behavior,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: content ?? Text(text ?? 'Unimplemented'),
        behavior: behavior,
      ),
    );
  }
}
