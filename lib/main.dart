// filepath: /Users/faressalah/Desktop/work/flutter_projects/expense_tracker_app/lib/main.dart
import 'package:expense_tracker_app/widgets/expenses.dart';
import 'package:expense_tracker_app/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 145, 233, 255));

var kDarkColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 51, 107, 121));

final TextTheme customDarkTextTheme = TextTheme(
  headlineLarge: TextStyle(color: Colors.white),
  headlineMedium: TextStyle(color: Colors.white),
  headlineSmall: TextStyle(color: Colors.white),
  titleLarge: TextStyle(color: Colors.white),
  titleMedium: TextStyle(color: Colors.white),
  titleSmall: TextStyle(color: Colors.white),
  bodySmall: TextStyle(color: Colors.white),
  bodyLarge: TextStyle(color: Colors.white),
  bodyMedium: TextStyle(color: Colors.white),
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((fn) {
    runApp(
      MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/home': (context) => Expenses(),
        },
        darkTheme: ThemeData.dark().copyWith(
          brightness: Brightness.dark,
          colorScheme: kDarkColorScheme,
          appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kDarkColorScheme.onPrimaryContainer,
            foregroundColor: kDarkColorScheme.primaryContainer,
          ),
          cardTheme: CardTheme().copyWith(
            color: kDarkColorScheme.primaryContainer,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          )),
          dialogTheme: DialogTheme(
            backgroundColor: kDarkColorScheme
                .onPrimaryContainer, // Set dialog background color
            titleTextStyle:
                TextStyle(color: Colors.white), // Set title text color
            contentTextStyle:
                TextStyle(color: Colors.white), // Set content text color
          ),
          bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: kDarkColorScheme
                .onPrimaryContainer, // Set bottom sheet background color
          ),
          textTheme: customDarkTextTheme,
        ),
        theme: ThemeData().copyWith(
          colorScheme: kColorScheme,
          appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
          ),
          cardTheme: CardTheme().copyWith(
            color: kColorScheme.primaryContainer,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
            foregroundColor: kColorScheme.onPrimaryContainer,
          )),
          textTheme: ThemeData().textTheme.copyWith(
              // Customize your text theme here
              ),
        ),
      ),
    );
  });
}
