import 'package:contacts/app/pages/home_contact/home_contact.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../app/pages/home_contact/add_contact.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(initialLocation: '/home', debugLogDiagnostics: true, routes: [
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          restorationId: state.pageKey.value,
          child: const HomeScreen()),
    ),
     GoRoute(
      path: '/addContact',
      pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          restorationId: state.pageKey.value,
          child: const AddContact()),
    ),

  ]);
});
