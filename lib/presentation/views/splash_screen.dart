import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => MainScreen());
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
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/splash.png',
            fit: BoxFit.cover,
          ),
          // Content
          Column(
            children: [
              const SizedBox(height: 60),
              // "My Store" title
              const Text(
                'My Store',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontFamily: 'Serif',
                ),
              ),

              const Spacer(),

              // Welcome text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: const [
                    Text(
                      'Valkommen',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Hos oss kan du boka tid hos nästan alla Sveriges salonger och mottagningar. Boka frisör, massage, skönhetsbehandlingar, friskvård och mycket mer.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ],
      ),
    );
  }
}
