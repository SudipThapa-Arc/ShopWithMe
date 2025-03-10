import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppPageTransition {
  static Route<T> fade<T>(Widget page) {
    return PageTransition(
      type: PageTransitionType.fade,
      child: page,
    );
  }

  static Route<T> rightToLeft<T>(Widget page) {
    return PageTransition(
      type: PageTransitionType.rightToLeft,
      child: page,
    );
  }

  static Route<T> leftToRight<T>(Widget page) {
    return PageTransition(
      type: PageTransitionType.leftToRight,
      child: page,
    );
  }

  static Route<T> upToDown<T>(Widget page) {
    return PageTransition(
      type: PageTransitionType.bottomToTop,
      child: page,
    );
  }

  static Route<T> downToUp<T>(Widget page) {
    return PageTransition(
      type: PageTransitionType.topToBottom,
      child: page,
    );
  }

  static Route<T> scale<T>(Widget page, {Alignment alignment = Alignment.center}) {
    return PageTransition(
      type: PageTransitionType.scale,
      alignment: alignment,
      child: page,
    );
  }

  static Route<T> size<T>(Widget page, {Alignment alignment = Alignment.center}) {
    return PageTransition(
      type: PageTransitionType.size,
      alignment: alignment,
      child: page,
    );
  }

  static Route<T> rotate<T>(Widget page, {Alignment alignment = Alignment.center}) {
    return PageTransition(
      type: PageTransitionType.rotate,
      alignment: alignment,
      child: page,
    );
  }
} 