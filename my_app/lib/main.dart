import 'package:flutter/material.dart';
import 'AccountantProfile.dart';
import 'AccountantsPage.dart';
import 'UserType.dart';
import 'accountantsChat.dart';
import 'accountantsDetails.dart';
import 'accountantsOrders.dart';
import 'chats.dart';
import 'chatInterface.dart';
import 'createOrders.dart';
import 'details.dart';
import 'home_screen.dart';
import 'orders.dart';
import 'profile.dart';
import 'colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: AppColors().backgroundColors),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SelectionPage(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/order': (context) => OrdersPage(),
        '/chat': (context) => ChatPage(),
        '/profile': (context) => ProfilePage(name: "ابراهيم الجهني"),
        '/chatInterface': (context) => ChatInterface(
              title: ModalRoute.of(context)!.settings.arguments as String,
            ),
        '/AccountantsPage': (context) => AccountantsPage(),
        '/details': (context) => OrderDetailsPage(),
        '/createOrders': (context) => RequestScreen(),
        '/accountantsOrders': (context) => accountantsOrders(),
        '/accountantsDetails': (context) => accountantsDetails(),
        '/Accountantprofile': (context) =>
            AccountantProfile(name: "محمد الشهري"),
        '/accountantsChat': (context) => accountantsChat(),
      },
    );
  }
}
