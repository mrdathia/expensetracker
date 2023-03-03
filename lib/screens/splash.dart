import 'dart:async';
import 'dart:convert';
import 'package:expensetracker/screens/allExpenses.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/appTools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/styleConstants.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  //final prefs = SharedPreferences.getInstance();
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   systemNavigationBarColor: Colors.blue, // navigation bar color
    //   statusBarColor: Colors.pink, // status bar color
    // ));
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();

    Timer(const Duration(seconds: 4),
        () => Navigator.of(context).push(_createRoute()));
  }

  @override
  Widget build(BuildContext context) {
    // given transparent color to status bar

    return Scaffold(
      body: Container(
        color: hexToColor("#101010"),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Expense Tracker",
                style: kGoogleStyleTextSplash.copyWith(
                  fontWeight: FontWeight.w300,
                  fontSize: 30,
                  color: hexToColor("#ffffff"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => AllExpenses(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }
}
