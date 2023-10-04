import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'pages/list_pages.dart';
import 'pages/post_pages.dart';
import 'pages/typography_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive Framework',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) {
          return BouncingScrollWrapper.builder(
              context, buildPage(settings.name ?? ''),
              dragWithMouse: true);
        });
      },
    );
  }
}

Widget buildPage(String name) {
  switch (name) {
    case '/':
    case ListPage.name:
      return const ListPage();
    case PostPage.name:
      // Custom "per-page" breakpoints.
      return const ResponsiveBreakpoints(breakpoints: [
        Breakpoint(start: 0, end: 480, name: MOBILE),
        Breakpoint(start: 481, end: 1200, name: TABLET),
        Breakpoint(start: 1201, end: double.infinity, name: DESKTOP),
      ], child: PostPage());
    case TypographyPage.name:
      return const TypographyPage();
    default:
      return const SizedBox.shrink();
  }
}
