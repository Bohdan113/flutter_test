import 'package:flutter/material.dart';
import 'package:flutter_test_app/website_bloc.dart';
import 'package:provider/provider.dart';
import 'my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<WebSiteBloc>(
          create: (_) => WebSiteBloc()),

    ],
    child: MyApp(),
  ),
  );
}
