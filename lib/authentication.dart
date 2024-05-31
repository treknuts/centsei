import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthFunc extends StatelessWidget {
  const AuthFunc({
    super.key,
    required this.loggedIn,
    required this.signOut,
  });

  final bool loggedIn;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
      return Visibility(
        visible: loggedIn,
        replacement: ElevatedButton(
          onPressed: () => context.push('/sign-in'),
          child: const Icon(Icons.login),
        ),
        child: ElevatedButton(
            onPressed: () {
              context.push('/profile');
            },
            child: const Icon(Icons.person),
        ),
      );
  }
}