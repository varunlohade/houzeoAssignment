import 'package:contacts/app/pages/home_contact/detail_contact.dart';
import 'package:contacts/app/pages/home_contact/home_contact.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../app/pages/home_contact/add_contact.dart';
import '../models/contact_model.dart';

class CustomSlideTransition extends CustomTransitionPage<void> {
  CustomSlideTransition({super.key, required super.child})
      : super(
          transitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: animation.drive(
                Tween(
                  begin: const Offset(1.5, 0),
                  end: Offset.zero,
                ).chain(
                  CurveTween(curve: Curves.ease),
                ),
              ),
              child: child,
            );
          },
        );
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(initialLocation: '/home', debugLogDiagnostics: true, routes: [
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          restorationId: state.pageKey.value,
          child:  HomeScreen()),
    ),
    GoRoute(
      path: '/addContact',
      pageBuilder: (context, state) {
        var contact = state.extra as Contact?;

        return CustomSlideTransition(
            key: state.pageKey,
            child: AddContact(
              contact: contact,
            ));
      },
    ),
    GoRoute(
      path: '/detailContact',
      pageBuilder: (context, state) {
        Contact contact = state.extra as Contact;

        return CustomSlideTransition(
            key: state.pageKey,
            child: DetailContact(
              contact: contact,
            ));
      },
    ),
  ]);
});
