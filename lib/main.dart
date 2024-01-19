import 'package:flutter/material.dart';
import 'package:fyp/routes/routes_import.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
      enabledDebugging: true,
      publicKey: 'test_public_key_47526417de2e476ca10ac91bc16d1c23',
      navigatorKey: _appRouter.navigatorKey,
      builder: (context, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: _appRouter.config(),
          localizationsDelegates: const [
            KhaltiLocalizations.delegate,
          ],
        );
      },
    );
  }
}
