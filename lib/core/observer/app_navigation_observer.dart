import 'dart:developer';

import 'package:flutter/material.dart';

class AppNavObserver extends NavigatorObserver {
  static final navStack = <RouteStackItem>[];

  @override
  void didPop(Route route, Route? previousRoute) {
    log('================== Navigation Info [didPop] ===================');
    log('[Current Page] -> [${route.settings.name}] | [Previous Page] -> [${previousRoute?.settings.name}] | [Argument] -> ${route.settings.arguments}');

    log('=' * 30);
    if (previousRoute != null) {
      navStack.removeLast();
    }

    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    log('================== Navigation Info [didPush] ===================');
    log('[Current Page] -> [${route.settings.name}] | [Previous Page] -> [${previousRoute?.settings.name}] | [Argument] -> [${route.settings.arguments}]');

    log('=' * 30);
    navStack.add(RouteStackItem.fromRoute(route));
    super.didPush(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    log('================== Navigation Info [didRemove] ===================');
    log('[Current Page] -> [${route.settings.name}] | [Previous Page] -> [${previousRoute?.settings.name}] | [Argument] -> [${route.settings.arguments}]');

    log('=' * 30);
    if (previousRoute != null) {
      navStack.removeLast();
    }
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    log('================== Navigation Info [didReplace] ===================');
    log('[Current Page] -> [${newRoute?.settings.name}] | [Previous Page] -> [${oldRoute?.settings.name}] | [Argument] -> [${newRoute?.settings.arguments}]');

    log('=' * 30);
    if (oldRoute != null) {
      navStack.removeLast();
    }
    if (newRoute != null) {
      navStack.add(RouteStackItem.fromRoute(newRoute));
    }
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    log('================== Navigation Info [didStartUserGesture] ===================');
    log('[Current Page] -> [${route.settings.name}] | [Previous Page] -> [${previousRoute?.settings.name}] | [Argument] -> [${route.settings.arguments}]');
    log('=' * 30);
    // TODO: implement didStartUserGesture
    super.didStartUserGesture(route, previousRoute);
  }

  @override
  void didStopUserGesture() {
    log('================== Navigation Info [ didStopUserGesture] ===================');
    super.didStopUserGesture();
  }
}

class RouteStackItem {
  final String? name;
  final Object? args;

  const RouteStackItem({
    required this.name,
    required this.args,
  });

  factory RouteStackItem.fromRoute(Route route) =>
      RouteStackItem(name: route.settings.name, args: route.settings.arguments);
}
