import 'package:app/views/home.dart';
import 'package:app/views/settings.dart';
import 'package:app/views/profile.dart';
import 'package:app/views/subreddit.dart';
import 'package:flutter/material.dart';
import 'package:mvc_application/view.dart'
    show AppMVC;
import 'roddit_colors.dart';

void main() =>
  runApp(Roddit());

class Roddit extends AppMVC {
  Roddit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      MaterialApp(
          title: "Roddit",
          theme: ThemeData(
              primarySwatch: RodditColors.pink,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: RodditColors.blue
              ),
              outlinedButtonTheme: OutlinedButtonThemeData(
                  style: OutlinedButton.styleFrom(
                    primary: RodditColors.blue,
                  )
              )
          ),
          initialRoute: '/',
          routes: {
            HomeView.routeName: (context) => const HomeView(title: "Roddit"),
            SettingsView.routeName: (context) => const SettingsView(title: "Settings"),
            ProfileView.routeName: (context) => const ProfileView(title: "Profile"),
            SubredditView.routeName: (context) => const SubredditView()
          }
      );
}