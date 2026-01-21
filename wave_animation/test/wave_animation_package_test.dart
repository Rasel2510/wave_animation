import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wave_animation/wave_animation.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Wave Animation Package Tests', () {
    testWidgets('WaveWidget builds with null values', (WidgetTester tester) async {
      // Build widget with null parameters
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WaveWidget(),
          ),
        ),
      );

      expect(find.byType(WaveWidget), findsOneWidget);
      expect(find.byType(CustomPaint), findsOneWidget);
    });

    testWidgets('WaveWidget builds with custom parameters', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WaveWidget(
              height: 150,
              gradientColors1: [Colors.red, Colors.orange],
              gradientColors2: [Colors.blue, Colors.lightBlue],
              lineCount: 10,
              amplitude: 20,
              waveLength: 100,
              speed: 1.0,
              pattern: WaveMotionPattern.flowFieldLoop,
              visible: true,
            ),
          ),
        ),
      );

      expect(find.byType(WaveWidget), findsOneWidget);
      expect(find.byType(CustomPaint), findsOneWidget);
    });

    test('WavePainter instantiation does not crash', () {
      final painter = WavePainter(
        animationValue: 0.5,
        gradientColors1: [Colors.red, Colors.orange],
        gradientColors2: [Colors.blue, Colors.lightBlue],
        lineCount: 10,
        amplitude: 20,
        waveLength: 100,
        pattern: WaveMotionPattern.ribbonLoop,
      );

      expect(painter, isA<WavePainter>());
    });
  });
}
