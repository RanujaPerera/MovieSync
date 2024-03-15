import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moviesync/auth_gate.dart';
import 'package:moviesync/home_screen.dart';
import 'package:moviesync/search_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Home screen displays properly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Verify that the app bar is displayed
    expect(find.byType(AppBar), findsOneWidget);

    // Verify that the 'Movies' text is displayed
    expect(find.text('Movies'), findsOneWidget);

    // Verify that the 'TV Shows' text is displayed
    expect(find.text('TV Shows'), findsOneWidget);
  });
  
  testWidgets('Trending Movies section displays properly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Verify that the 'Trending Movies' text is displayed
    expect(find.text('Trending Movies'), findsOneWidget);
  });

  testWidgets('Now Playing section displays properly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Verify that the 'Now Playing' text is displayed
    expect(find.text('Now Playing'), findsOneWidget);

  });

  testWidgets('Upcoming Movies section displays properly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Verify that the 'Upcoming Movies' text is displayed
    expect(find.text('Upcoming Movies'), findsOneWidget);

  });

  // Test navigation to SearchScreen
  testWidgets('Navigation to SearchScreen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Tap on the search icon
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    // Verify that the SearchScreen is displayed
    expect(find.byType(SearchScreen), findsOneWidget);
  });

  // Test menu button functionality
  testWidgets('Menu button opens menu', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Tap on the menu icon
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pump();

    // Verify that the menu is displayed
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Watch List'), findsOneWidget);
    expect(find.text('Quit'), findsOneWidget);
  });

  testWidgets('AuthGate navigates to HomeScreen if "Remember Me" is checked', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({
      'rememberMe': true,
      'username': 'test@example.com',
      'password': 'password123',
    });

    await tester.pumpWidget(MaterialApp(home: AuthGate()));

    // Verify that navigation to HomeScreen is triggered
    await tester.pumpAndSettle();
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
