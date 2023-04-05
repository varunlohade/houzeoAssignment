import 'package:contacts/constants/style/theme.dart';
import 'package:contacts/router/router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Contacts extends ConsumerWidget {
  const Contacts({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      routerConfig: router,
    );
  }
}
