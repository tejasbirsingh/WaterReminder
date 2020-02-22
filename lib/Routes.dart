  import 'package:flutter/material.dart';

  class routeanimation extends PageRouteBuilder {
    final Widget page;
    routeanimation({this.page})
        : super(
      pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          ) =>
      page,
      transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
          ) =>
          FadeTransition(
            opacity: animation,
            child: child,
          ),
    );
  }