import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_system/provider/home_provider.dart';
import 'package:solar_system/routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 30), // Adjusted for smoother animation
      vsync: this,
    )..repeat();
    context.read<HomeProvider>().getPlanet();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<HomeProvider>();

    final planetSizes = [
      50.0,
      90.0,
      90.0,
      140.0,
      120.0,
      130.0,
      100.0,
      110.0,
      160.0,
    ];


    const orbitRadius = 160.0; // Increased orbit radius for better spacing

    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueGrey.withOpacity(0.5), Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Image.asset(
                'assets/background/bg.jpeg',
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.4),
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "The Universe",
              style: TextStyle(
                  fontSize: 48, // Increased font size
                  fontWeight: FontWeight.bold,
                  color: Colors.white70),
            ),
          ),
          AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Center(
                child: Stack(
                  children: [
                    Positioned(
                      left: MediaQuery.of(context).size.width / 2 -
                          planetSizes[8] / 2,
                      top: MediaQuery.of(context).size.height / 2 -
                          planetSizes[8] / 2,
                      child: Image.asset(
                        'assets/images/Sun.png',
                        width: planetSizes[8],
                        height: planetSizes[8],
                      ),
                    ),
                    ...List.generate(watch.planetList.length, (index) {
                      final angle =
                          controller.value * 2 * pi - (index * pi / 4);

                      final offsetX = orbitRadius * cos(angle + pi / 8);
                      final offsetY = orbitRadius * 2 * sin(angle);

                      return Positioned(
                        left: MediaQuery.of(context).size.width / 2 -
                            planetSizes[index] / 2 +
                            offsetX,
                        top: MediaQuery.of(context).size.height / 2 -
                            planetSizes[index] / 2 +
                            offsetY,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.detail,
                              arguments: watch.planetList[index],
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    watch.planetList[index].image,
                                    width: planetSizes[index],
                                    height: planetSizes[index],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                watch.planetList[index].name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16, // Increased font size
                                  fontWeight: FontWeight.w600, // Bolder font weight
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.favorite);
        },
        backgroundColor: Colors.amber.shade300, // Changed color
        child: const Icon(
          Icons.star,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}