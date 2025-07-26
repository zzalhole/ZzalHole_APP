import 'package:flutter/material.dart';
import 'package:zzal_hole/core/component/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (builder) => MainScreen()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff4E3729),
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 1),
          child: const Text(
            '짤구덩이',
            style: TextStyle(
              color: Color(0xffFFF7F2),
              fontSize: 50,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
