import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const ShapesDemoApp());
}

class ShapesDemoApp extends StatelessWidget {
  const ShapesDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shapes Drawing Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ShapesDemoScreen(),
    );
  }
}

class ShapesDemoScreen extends StatefulWidget {
  const ShapesDemoScreen({super.key});

  @override
  State<ShapesDemoScreen> createState() => _ShapesDemoScreenState();
}

class _ShapesDemoScreenState extends State<ShapesDemoScreen> {
  String selectedEmoji = "Smiley";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shapes Drawing Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            const Text('Task 1: Basic Shapes',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SizedBox(
                height: 200,
                child: CustomPaint(
                    painter: BasicShapesPainter(),
                    size: const Size(double.infinity, 200))),

            const SizedBox(height: 20),
            
            const Text('Task 2: Combined Shapes (Abstract Design)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SizedBox(
                height: 300,
                child: CustomPaint(
                    painter: CombinedShapesPainter(),
                    size: const Size(double.infinity, 300))),

            const SizedBox(height: 20),
            
            const Text('Task 3: Styled Shapes',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SizedBox(
                height: 300,
                child: CustomPaint(
                    painter: StyledShapesPainter(),
                    size: const Size(double.infinity, 300))),

            const SizedBox(height: 20),
            
            const Text('Task 4: Smiley Face (with Gradient)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SizedBox(
                height: 250,
                child: CustomPaint(
                    painter: SmileyFacePainter(),
                    size: const Size(double.infinity, 250))),

            const SizedBox(height: 20),
            
            const Text('Interactive Emoji Selector',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            DropdownButton<String>(
              value: selectedEmoji,
              items: const [
                DropdownMenuItem(value: "Smiley", child: Text("😀 Smiley Face")),
                DropdownMenuItem(value: "Heart", child: Text("❤️ Heart")),
                DropdownMenuItem(value: "Party", child: Text("🥳 Party Face")),
              ],
              onChanged: (value) {
                setState(() {
                  selectedEmoji = value!;
                });
              },
            ),

            const SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: CustomPaint(
                painter: EmojiPainter(selectedEmoji),
                size: const Size(double.infinity, 300),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class BasicShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final squareOffset = Offset(centerX - 80, centerY);
    final circleOffset = Offset(centerX, centerY);
    final arcOffset = Offset(centerX + 80, centerY);
    final rectOffset = Offset(centerX - 160, centerY);
    final ovalOffset = Offset(centerX + 160, centerY);

    canvas.drawRect(
        Rect.fromCenter(center: squareOffset, width: 60, height: 60),
        Paint()..color = Colors.blue);

    canvas.drawCircle(circleOffset, 30, Paint()..color = Colors.red);

    canvas.drawArc(
        Rect.fromCenter(center: arcOffset, width: 60, height: 60),
        0,
        2.1,
        false,
        Paint()
          ..color = Colors.green
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5);

    canvas.drawRect(
        Rect.fromCenter(center: rectOffset, width: 80, height: 40),
        Paint()..color = Colors.orange);

    final trianglePath = Path()
      ..moveTo(centerX - 200, centerY - 50)
      ..lineTo(centerX - 140, centerY + 50)
      ..lineTo(centerX - 180, centerY + 60)
      ..close();
    canvas.drawPath(trianglePath, Paint()..color = Colors.purple);

    canvas.drawOval(
        Rect.fromCenter(center: ovalOffset, width: 80, height: 40),
        Paint()..color = Colors.teal);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


class CombinedShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final backgroundGradient =
        RadialGradient(center: Alignment.center, radius: 0.8, colors: [
      Colors.blue.shade100,
      Colors.white,
    ]);
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()
          ..shader = backgroundGradient
              .createShader(Rect.fromLTWH(0, 0, size.width, size.height)));

    canvas.drawCircle(Offset(centerX, centerY - 40), 40, Paint()..color = Colors.yellow);

    final rayPaint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 3;
    for (int i = 0; i < 8; i++) {
      final angle = i * (pi / 4);
      final dx = cos(angle) * 60;
      final dy = sin(angle) * 60;
      canvas.drawLine(Offset(centerX, centerY - 40),
          Offset(centerX + dx, centerY - 40 + dy), rayPaint);
    }

    canvas.drawRect(
        Rect.fromCenter(center: Offset(centerX, centerY + 40), width: 80, height: 80),
        Paint()..color = Colors.brown);

    final roofPath = Path()
      ..moveTo(centerX - 60, centerY)
      ..lineTo(centerX + 60, centerY)
      ..lineTo(centerX, centerY - 60)
      ..close();
    canvas.drawPath(roofPath, Paint()..color = Colors.red);

    canvas.drawRect(
        Rect.fromCenter(center: Offset(centerX, centerY + 60), width: 30, height: 50),
        Paint()..color = Colors.blueGrey);

    final windowPaint = Paint()..color = Colors.blue.shade200;
    canvas.drawRect(
        Rect.fromCenter(center: Offset(centerX - 25, centerY + 20), width: 20, height: 20),
        windowPaint);
    canvas.drawRect(
        Rect.fromCenter(center: Offset(centerX + 25, centerY + 20), width: 20, height: 20),
        windowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


class StyledShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final rect = Rect.fromCenter(center: Offset(centerX, centerY - 100), width: 200, height: 60);
    final rectGradient = LinearGradient(colors: [Colors.red, Colors.blue]);
    canvas.drawRect(rect, Paint()..shader = rectGradient.createShader(rect));

    canvas.drawCircle(Offset(centerX - 80, centerY), 40, Paint()..color = Colors.green);
    canvas.drawCircle(
        Offset(centerX - 80, centerY),
        40,
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4);

    canvas.drawOval(
        Rect.fromCenter(center: Offset(centerX + 80, centerY), width: 100, height: 60),
        Paint()..color = Colors.purple.withOpacity(0.5));

    final dashPaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    final path = Path();
    double startX = centerX - 100;
    const dashLength = 10.0;
    const spaceLength = 5.0;
    while (startX < centerX + 100) {
      path.moveTo(startX, centerY + 80);
      path.lineTo(min(startX + dashLength, centerX + 100), centerY + 80);
      startX += dashLength + spaceLength;
    }
    canvas.drawPath(path, dashPaint);

    final arcRect = Rect.fromCenter(center: Offset(centerX, centerY + 100), width: 120, height: 120);
    final arcGradient = SweepGradient(startAngle: 0, endAngle: pi, colors: [Colors.red, Colors.yellow, Colors.green]);
    canvas.drawArc(
        Rect.fromCenter(center: Offset(centerX, centerY + 100), width: 100, height: 100),
        0,
        2.5,
        false,
        Paint()
          ..shader = arcGradient.createShader(arcRect)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10
          ..strokeCap = StrokeCap.round);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


class SmileyFacePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    
    final bgPaint = Paint()
      ..shader = RadialGradient(
        colors: [Colors.lightBlue.shade100, Colors.white],
        radius: 0.8,
        center: Alignment.center,
      ).createShader(rect);
    canvas.drawRect(rect, bgPaint);

    final center = Offset(size.width / 2, size.height / 2);
    final facePaint = Paint()..color = Colors.yellow;
    canvas.drawCircle(center, 100, facePaint);

    final eyePaint = Paint()..color = Colors.black;
    canvas.drawCircle(Offset(center.dx - 40, center.dy - 30), 15, eyePaint);
    canvas.drawCircle(Offset(center.dx + 40, center.dy - 30), 15, eyePaint);

    final smileRect = Rect.fromCenter(center: center.translate(0, 20), width: 120, height: 80);
    final smilePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(smileRect, 0, pi, false, smilePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


class EmojiPainter extends CustomPainter {
  final String emoji;
  EmojiPainter(this.emoji);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    
    final bgPaint = Paint()
      ..shader = RadialGradient(
        colors: [Colors.pink.shade100, Colors.white],
        radius: 0.9,
        center: Alignment.center,
      ).createShader(rect);
    canvas.drawRect(rect, bgPaint);

    if (emoji == "Smiley") {
      _drawSmiley(canvas, size);
    } else if (emoji == "Heart") {
      _drawHeart(canvas, size);
    } else if (emoji == "Party") {
      _drawPartyFace(canvas, size);
    }
  }

  void _drawSmiley(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, 100, Paint()..color = Colors.yellow);
    canvas.drawCircle(Offset(center.dx - 40, center.dy - 30), 15, Paint()..color = Colors.black);
    canvas.drawCircle(Offset(center.dx + 40, center.dy - 30), 15, Paint()..color = Colors.black);
    canvas.drawArc(Rect.fromCenter(center: center.translate(0, 20), width: 120, height: 80),
        0, pi, false, Paint()..color = Colors.black..style = PaintingStyle.stroke..strokeWidth = 6);
  }

  void _drawHeart(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.red;
    final path = Path()
      ..moveTo(size.width / 2, size.height / 2 + 30)
      ..cubicTo(size.width / 2 + 80, size.height / 2 - 40, size.width / 2 + 40,
          size.height / 2 - 120, size.width / 2, size.height / 2 - 60)
      ..cubicTo(size.width / 2 - 40, size.height / 2 - 120, size.width / 2 - 80,
          size.height / 2 - 40, size.width / 2, size.height / 2 + 30)
      ..close();
    canvas.drawPath(path, paint);
  }

  void _drawPartyFace(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, 100, Paint()..color = Colors.yellow);
    canvas.drawCircle(Offset(center.dx - 40, center.dy - 30), 15, Paint()..color = Colors.black);
    canvas.drawCircle(Offset(center.dx + 40, center.dy - 30), 15, Paint()..color = Colors.black);
    canvas.drawArc(Rect.fromCenter(center: center.translate(0, 20), width: 120, height: 80),
        0, pi, false, Paint()..color = Colors.black..style = PaintingStyle.stroke..strokeWidth = 6);

    final hatPath = Path()
      ..moveTo(center.dx, center.dy - 120)
      ..lineTo(center.dx - 50, center.dy - 20)
      ..lineTo(center.dx + 50, center.dy - 20)
      ..close();
    canvas.drawPath(hatPath, Paint()..color = Colors.blueAccent);

    canvas.drawCircle(center.translate(-80, 20), 5, Paint()..color = Colors.pink);
    canvas.drawCircle(center.translate(90, -10), 5, Paint()..color = Colors.green);
    canvas.drawCircle(center.translate(50, 80), 5, Paint()..color = Colors.orange);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
