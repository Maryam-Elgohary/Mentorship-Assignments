import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Sequential Loading Dots"),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: ThreeDotsLoading(),
        ),
      ),
    );
  }
}

class ThreeDotsLoading extends StatefulWidget {
  const ThreeDotsLoading({Key? key}) : super(key: key);

  @override
  State<ThreeDotsLoading> createState() => _ThreeDotsLoadingState();
}

class _ThreeDotsLoadingState extends State<ThreeDotsLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _scales;
  late List<Animation<double>> _opacities;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _scales = List.generate(3, (index) {
      return Tween<double>(begin: 0.5, end: 1.2).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index * 0.2,
            index * 0.2 + 0.6,
            curve: Curves.easeInOut,
          ),
        ),
      );
    });

    _opacities = List.generate(3, (index) {
      return Tween<double>(begin: 0.2, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index * 0.2,
            index * 0.2 + 0.6,
            curve: Curves.easeInOut,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDot(int index) {
    return ScaleTransition(
      scale: _scales[index],
      child: FadeTransition(
        opacity: _opacities[index],
        child: Container(
          width: 16,
          height: 16,
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDot(0),
        const SizedBox(width: 2),
        _buildDot(1),
        const SizedBox(width: 2),
        _buildDot(2),
      ],
    );
  }
}
