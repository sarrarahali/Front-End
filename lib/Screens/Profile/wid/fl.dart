import 'dart:convert';
import 'dart:convert';
import 'dart:convert';
import 'dart:typed_data';


import 'package:boy/Widgets/Colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_line_graph/utils/extension.dart';

class CurvedChartPainter extends CustomPainter {
  
  final List<Map<String, double>> xValues;
  final List<Map<String, double>> yValues;
  final Color? color;
  final double strokeWidth;
  final List<Color> gradientColors;
  final List<double> gradientStops;
  final TextStyle labelTextStyle;
   
  


  
  CurvedChartPainter({
    required this.xValues,
    required this.yValues,
    required this.strokeWidth,
    this.color,
   
    this.gradientColors = const [
      
      Colors.deepPurple,
      Color.fromARGB(255, 249, 247, 247),
    ],
    this.gradientStops = const [0.0, 0.9],
    this.labelTextStyle = const TextStyle(color: Colors.grey, fontSize: 15), 
  });

 
  @override
  void paint(Canvas canvas, Size size) {
   
    var paint = Paint();
    paint.color =  GlobalColors.mainColor;
    paint.style = PaintingStyle.stroke;
    
    paint.strokeWidth = strokeWidth;

    
    var fillPaint = Paint();
    fillPaint.style = PaintingStyle.fill;

   
    var axisPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0 ;

  
    canvas.drawLine(
        Offset(0, size.height), Offset(size.width, size.height), axisPaint);

    
    canvas.drawLine(const Offset(0, 0), Offset(0, size.height), axisPaint);

    var path = Path();
    var fillPath = Path();

 
    if (xValues.length > 1 && yValues.isNotEmpty) {
    
      final maxValue = yValues.last.values.last;
      final firstValueHeight =
          size.height * (xValues.first.values.first / maxValue);

    
      path.moveTo(0.0, size.height - firstValueHeight);
      fillPath.moveTo(0.0, size.height);
      fillPath.lineTo(0.0, size.height - firstValueHeight);

     
      final itemXDistance = size.width / (xValues.length - 1);

      for (var i = 1; i < xValues.length; i++) {
        final x = itemXDistance * i;
        final valueHeight = size.height -
            strokeWidth -
            ((size.height - strokeWidth) *
                (xValues[i].values.elementAt(0) / maxValue));
        final previousValueHeight = size.height -
            strokeWidth -
            ((size.height - strokeWidth) *
                (xValues[i - 1].values.elementAt(0) / maxValue));

        path.quadraticBezierTo(
          x - (itemXDistance / 2) - (itemXDistance / 8),
          previousValueHeight,
          x - (itemXDistance / 2),
          valueHeight + ((previousValueHeight - valueHeight) / 2),
        );
        path.quadraticBezierTo(
          x - (itemXDistance / 2) + (itemXDistance / 8),
          valueHeight,
          x,
          valueHeight,
        );

        
        fillPath.quadraticBezierTo(
          x - (itemXDistance / 2) - (itemXDistance / 8),
          previousValueHeight,
          x - (itemXDistance / 2),
          valueHeight + ((previousValueHeight - valueHeight) / 2),
        );
        fillPath.quadraticBezierTo(
          x - (itemXDistance / 2) + (itemXDistance / 8),
          valueHeight,
          x,
          valueHeight,
        );


          canvas.drawCircle(
    Offset(x, size.height - (size.height * xValues[i].values.first / maxValue)),
    5, 
    Paint()..color = GlobalColors.mainColor,
  );
  
      }

     
      fillPath.lineTo(size.width, size.height);
      fillPath.close();
    }

   
    LinearGradient gradient = LinearGradient(
      colors: gradientColors,
      stops: gradientStops,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
     
    );
    
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    fillPaint.shader = gradient.createShader(rect);


 
    
    canvas.drawPath(fillPath, fillPaint);

   
    canvas.drawPath(path, paint);

    
    for (int i = 0; i < xValues.length; i++) {
      double x = size.width * i / (xValues.length - 1);
      var textPainter = TextPainter(
        text:
            TextSpan(text: xValues[i].keys.elementAt(0), style: labelTextStyle),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
          canvas, Offset(x - textPainter.width / 2, size.height + 2));


          
    }

    
  }

  
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}



