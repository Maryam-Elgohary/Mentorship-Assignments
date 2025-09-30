import 'package:flutter/material.dart';

void main() {
  runApp(const PhysicsApp());
}

class PhysicsApp extends StatelessWidget {
  const PhysicsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Physics Playground',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
      home: const PhysicsPlayground(),
    );
  }
}

class PhysicsPlayground extends StatefulWidget {
  const PhysicsPlayground({super.key});

  @override
  State<PhysicsPlayground> createState() => _PhysicsPlaygroundState();
}

class _PhysicsPlaygroundState extends State<PhysicsPlayground> {
  final List<Color> ballColors = [Colors.red, Colors.blue, Colors.green];
  final Map<Color, bool> matched = {};

  @override
  void initState() {
    super.initState();
    for (var color in ballColors) {
      matched[color] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("Physics Playground"), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Draggable Balls
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ballColors.map((color) {
              return matched[color] == true
                  ? Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                    ) // hide if matched
                  : Draggable<Color>(
                      data: color,
                      feedback: _buildBall(color, 70, opacity: 0.7),
                      childWhenDragging: _buildBall(color, 60, opacity: 0.3),
                      child: _buildBall(color, 60),
                    );
            }).toList(),
          ),

          // Drag Targets
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ballColors.map((color) {
              return DragTarget<Color>(
                onWillAccept: (data) => true,
                onAccept: (data) {
                  setState(() {
                    if (data == color) {
                      matched[color] = true;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text("Correct match for ${colorName(color)}!")),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Wrong match! Try again.")),
                      );
                    }
                  });
                },
                builder: (context, candidateData, rejectedData) {
                  final isActive = candidateData.isNotEmpty;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: matched[color]! ? color : color.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isActive ? color : color.withOpacity(0.7),
                        width: 3,
                      ),
                    ),
                    child: matched[color]!
                        ? Icon(Icons.check, color: Colors.white, size: 30)
                        : isActive
                            ? Icon(Icons.arrow_downward_rounded,
                                color: Colors.white, size: 30)
                            : null,
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBall(Color color, double size, {double opacity = 1}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(opacity),
        shape: BoxShape.circle,
      ),
    );
  }

  String colorName(Color color) {
    if (color == Colors.red) return "Red";
    if (color == Colors.blue) return "Blue";
    if (color == Colors.green) return "Green";
    return "Color";
  }
}
