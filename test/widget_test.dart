// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fruitshopweb/ui/auth/login_screen.dart';
import 'package:fruitshopweb/ui/auth/register_screen.dart';
import 'package:fruitshopweb/ui/home/orders/order_history_screen.dart';
import 'package:fruitshopweb/ui/home/sell/products_screen.dart';

void main(){

  testWidgets('LoginScreen widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: LoginScreen(),
    ));

    // Verify that the initial state is as expected.
    expect(find.text('Sign In'), findsAtLeastNWidgets);
    expect(find.text('Continue'), findsAtLeastNWidgets);

  });

  testWidgets('RegisterScreen widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: RegisterScreen(),
    ));

    // Verify that the initial state is as expected.
    expect(find.text('Register'), findsAtLeastNWidgets);
    expect(find.text('Sign In Here'), findsAtLeastNWidgets);
  });

  testWidgets('ProductsScreen widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: ProductsScreen(),
    ));

    // Verify that the initial state is as expected.
    expect(find.text('Fruits'), findsAtLeastNWidgets);
  });

  testWidgets('OrderScreen widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: OrderScreen(),
    ));

    // Verify that the initial state is as expected.
    expect(find.text('Past Orders'), findsAtLeastNWidgets);
  });

}


