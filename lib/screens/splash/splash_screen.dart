import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_system/screens/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black87, Colors.blueAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: FadeTransition(
              opacity: _controller.drive(CurveTween(curve: Curves.easeInOut)),
              child: RotationTransition(
                turns: _controller,
                child: Image.asset(
                  'assets/images/Mars.png',
                  width: 200, // Increased size
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80.0), // Adjusted padding
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TweenAnimationBuilder(
                    duration: const Duration(milliseconds: 2000),
                    curve: Curves.easeInOut,
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    builder: (context, double value, _) {
                      return Opacity(
                        opacity: value,
                        child: Column(
                          children: [
                            Text(
                              "Discover",
                              style: GoogleFonts.orbitron(
                                color: Colors.white,
                                fontSize: 60 * value, // Increased font size
                                fontWeight: FontWeight.w900, // Bolder font weight
                                shadows: [
                                  Shadow(
                                    color: Colors.blueAccent,
                                    blurRadius: 20.0,
                                  )
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "The Universe",
                              style: GoogleFonts.orbitron(
                                color: Colors.lightBlueAccent,
                                fontSize: 50 * value, // Increased font size
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}