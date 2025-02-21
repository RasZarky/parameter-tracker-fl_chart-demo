import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

class GraphPage extends StatefulWidget {
  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  int? _selectedIndex;
  int? _selectedIndex2;
  ui.Image? _customPImage;
  ui.Image? _customNImage;
  ui.Image? _customCommentImage;
  ui.Image? _customResponseImage;
  ui.Image? _customPositiveAbnormalImage;

  final List<Map<String, dynamic>> jsonData = [
    {"x": "Jan \n25", "y": 120, "institute": "Regional Hospital Sunyani", "originalValue": "120 mg/dl"},
    {"x": "Feb \n25", "y": 80, "institute": "City Clinic Accra", "originalValue": "80 mg/dl"},
    {"x": "Mar \n25", "y": 0, "institute": "Health Facility Kumasi", "originalValue": "Positive"},
    {"x": "Apr \n25", "y": 60, "institute": "District Hospital Cape Coast", "originalValue": "60 mg/dl"},
    {"x": "May \n25", "y": 111, "institute": "Local Hospital Tamale", "originalValue": "111 mg/dl"},
    {"x": "Jun \n25", "y": 0, "institute": "District Hospital Cape Coast", "originalValue": "Comment"},
    {"x": "July \n25", "y": 0, "institute": "District Hospital Cape Coast", "originalValue": "Negative"},
    {"x": "Aug \n25", "y": 45, "institute": "District Hospital Cape Coast", "originalValue": "60 mg/dl"},
    {"x": "Sep \n25", "y": 0, "institute": "District Hospital Cape Coast", "originalValue": "No response"},
    {"x": "Oct \n25", "y": 0, "institute": "District Hospital Cape Coast", "originalValue": "Positive abnormal"},
  ];

  ui.Image? getImageForOriginalValue(String originalValue) {
    switch (originalValue) {
      case 'Positive':
        return _customPImage;
      case 'Negative':
        return _customNImage;
      case 'Comment':
        return _customCommentImage;
      case 'No response':
        return _customResponseImage;
      case 'Positive abnormal':
        return _customPositiveAbnormalImage;
      default:
        return _customCommentImage; // Return null or a default image for unknown values
    }
  }

  @override
  void initState() {
    super.initState();
    _loadCustomImages();
  }

  Future<void> _loadCustomImages() async {
    final ByteData data = await rootBundle.load('assets/images/negative_abnormal.png');
    final ByteData data2 = await rootBundle.load('assets/images/positive.png');
    final ByteData data3 = await rootBundle.load('assets/images/comment.png');
    final ByteData data4 = await rootBundle.load('assets/images/no_response.png');
    final ByteData data5 = await rootBundle.load('assets/images/positive_abnormal.png');
    final ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final ui.Codec codec2 = await ui.instantiateImageCodec(data2.buffer.asUint8List());
    final ui.Codec codec3 = await ui.instantiateImageCodec(data3.buffer.asUint8List());
    final ui.Codec codec4 = await ui.instantiateImageCodec(data4.buffer.asUint8List());
    final ui.Codec codec5 = await ui.instantiateImageCodec(data5.buffer.asUint8List());
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ui.FrameInfo frameInfo2 = await codec2.getNextFrame();
    final ui.FrameInfo frameInfo3 = await codec3.getNextFrame();
    final ui.FrameInfo frameInfo4 = await codec4.getNextFrame();
    final ui.FrameInfo frameInfo5 = await codec5.getNextFrame();
    setState(() {
      _customPImage = frameInfo2.image;
      _customNImage = frameInfo.image;
      _customCommentImage = frameInfo3.image;
      _customResponseImage = frameInfo4.image;
      _customPositiveAbnormalImage = frameInfo5.image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> spots = jsonData
        .asMap()
        .entries
        .map((entry) => FlSpot(entry.key.toDouble(), entry.value["y"].toDouble()))
        .toList();

    final List<String> xLabels = jsonData.map((data) => data["x"] as String).toList();
    final List<double> yLabels = jsonData.map((data) => (data["y"] as num).toDouble())
        .toSet()
        .toList()
      ..sort();

    // Filter spots for the second line (special cases)
    final List<int> specialIndices = [];
    final List<FlSpot> specialSpots = spots.where((spot) {
      int index = spots.indexOf(spot); // Get the index of the spot
      String originalValue = jsonData[index]['originalValue']; // Get the originalValue
      bool isSpecial = [
        'Positive',
        'Negative',
        'Comment',
        'No response',
        'Positive abnormal',
      ].contains(originalValue);
      if (isSpecial) {
        specialIndices.add(index); // Track the original index
      }
      return isSpecial;
    }).toList();

// Filter spots for the first line (normal cases)
    final List<int> normalIndices = [];
    final List<FlSpot> normalSpots = spots.where((spot) {
      int index = spots.indexOf(spot); // Get the index of the spot
      String originalValue = jsonData[index]['originalValue']; // Get the originalValue
      bool isNormal = ![
        'Positive',
        'Negative',
        'Comment',
        'No response',
        'Positive abnormal',
      ].contains(originalValue);
      if (isNormal) {
        normalIndices.add(index); // Track the original index
      }
      return isNormal;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Graph Representation'),
      ),
      body: Container(
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border(bottom: BorderSide()),
          boxShadow: [
            BoxShadow(color: Colors.black, blurRadius: 19),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Parameter History',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child: Icon(
                          Icons.show_chart,
                          color: Colors.purple,
                        ),
                      ),
                      Icon(Icons.menu),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '6 Months',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey.shade500),
                  ),
                  Text(
                    '1 Year',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey.shade500),
                  ),
                  Text(
                    '3 Years',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey.shade500),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Text(
                      'All',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.purple),
                    ),
                  ),
                ],
              ),
            ),
            if (_selectedIndex != null)
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Original Value',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    color: Colors.grey.shade500),
                              ),
                              Text(
                                jsonData[_selectedIndex!]['originalValue'],
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade900),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Normal range',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    color: Colors.grey.shade500),
                              ),
                              Text(
                                '111 - 343',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade900),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Institute',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                                color: Colors.grey.shade500),
                          ),
                          Text(
                            jsonData[_selectedIndex!]['institute'],
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade900),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            if (_selectedIndex2 != null)
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Date',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    color: Colors.grey.shade500),
                              ),
                              Text(
                                jsonData[_selectedIndex2!]['x'],
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade900),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Normal range',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    color: Colors.grey.shade500),
                              ),
                              Text(
                                '111 - 343',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade900),
                              )
                            ],
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            if (_selectedIndex == null && _selectedIndex2 == null)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Text(
                    'Select a point on the graph to see details.',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ),
              ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 12,),
                      Container(
                        color: Colors.green,
                        height: 10,
                        width: 10,
                      ),
                      SizedBox(width: 8,),
                      Text(
                        'Normal',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey.shade900),
                      ),
                    ],
                  ),
                  SizedBox(width: 18,),
                  Row(
                    children: [
                      SizedBox(width: 12,),
                      Container(
                        color: Colors.red,
                        height: 10,
                        width: 10,
                      ),
                      SizedBox(width: 8,),
                      Text(
                        'Abnormal',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey.shade900),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 251,
                child: LineChart(
                  LineChartData(
                    minX: 0,
                    maxX: jsonData.length.toDouble() - 1,
                    minY: yLabels.first,
                    maxY: yLabels.last,
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    extraLinesData: ExtraLinesData(
                      horizontalLines: yLabels.map((yValue) {
                        return HorizontalLine(
                          y: yValue,
                          color: Colors.grey.shade300,
                          strokeWidth: 1,
                          dashArray: [5, 5], // Dashed line style
                        );
                      }).toList(),
                    ),
                    titlesData: FlTitlesData(
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                          reservedSize: 30,
                          getTitlesWidget: (value, meta) {
                            if (yLabels.contains(value)) {
                              return Text(value.toInt().toString());
                            }
                            return Text('');
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          minIncluded: true,
                          showTitles: true,
                          reservedSize: 50,
                          getTitlesWidget: (value, meta) {
                            if (yLabels.contains(value)) {
                              return Text(value.toInt().toString(), style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: Colors.grey.shade500),);
                            }
                            return Text('');
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 50,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            int index = value.round();
                            if (index >= 0 && index < xLabels.length) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Text(
                                  xLabels[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              );
                            }
                            return SizedBox.shrink(); // Return an empty widget for invalid indices
                          },
                        ),
                      ),

                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    lineBarsData: [
                      // First LineChartBarData: Connect all dots except x = 0
                      LineChartBarData(
                        spots: normalSpots, // Exclude x = 0
                        isCurved: false,
                        color: Colors.black,
                        barWidth: 2,
                        isStrokeCapRound: true,
                        belowBarData: BarAreaData(show: false),
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              int originalIndex = normalIndices[index]; // Get the original index
                              bool isSelected = _selectedIndex == originalIndex;
                              return FlDotCirclePainter(
                                radius: 8,
                                color: jsonData[index]['y'] >= 111 ? Colors.green : Colors.red,
                                strokeColor: isSelected ? Colors.grey : Colors.transparent,
                                strokeWidth: 6,
                              );

                              //   CustomDotPainter(
                              //   radius: 10,
                              //   color: jsonData[index]['y'] >= 111 ? Colors.green : Colors.red,
                              //   strokeColor: isSelected ? Colors.grey : Colors.transparent,
                              //   strokeWidth: 6,
                              //   value: jsonData[index]['y'].toString(),
                              //   institute: jsonData[index]['institute'],
                              //   isSelected: isSelected,
                              // );


                              //   CustomIconDotPainter(
                              //   icon: Icons.accessibility,
                              //   color: jsonData[index]['y'] >= 111 ? Colors.green : Colors.red,
                              //   isSelected: isSelected,
                              // );

                            },
                          ) // Hide dots for this line
                      ),

                      // Second LineChartBarData: Display all dots, including x = 0
                      LineChartBarData(
                        spots: specialSpots,
                        isCurved: false,
                        color: Colors.transparent,
                        barWidth: 0,
                        isStrokeCapRound: true,
                        belowBarData: BarAreaData(show: false),
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, barData, index) {
                            int originalIndex = specialIndices[index]; // Get the original index
                            bool isSelected = _selectedIndex2 == originalIndex;
                            return CustomImagePainter(
                              getImageForOriginalValue(jsonData[originalIndex]['originalValue'])!,
                              isSelected: isSelected, // Pass the selection state
                            );

                            //   CustomDotPainter(
                            //   radius: 10,
                            //   color: jsonData[index]['y'] >= 111 ? Colors.green : Colors.red,
                            //   strokeColor: isSelected ? Colors.grey : Colors.transparent,
                            //   strokeWidth: 6,
                            //   value: jsonData[index]['y'].toString(),
                            //   institute: jsonData[index]['institute'],
                            //   isSelected: isSelected,
                            // );


                            //   CustomIconDotPainter(
                            //   icon: Icons.accessibility,
                            //   color: jsonData[index]['y'] >= 111 ? Colors.green : Colors.red,
                            //   isSelected: isSelected,
                            // );

                          },
                        ),
                      ),

                    ],

                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        getTooltipItems: (List<LineBarSpot> touchedSpots) {
                          return []; // Disable tooltip
                        },
                      ),
                      handleBuiltInTouches: true,
                      touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {
                        if (touchResponse != null &&
                            touchResponse.lineBarSpots != null &&
                            touchResponse.lineBarSpots!.isNotEmpty) {
                          setState(() {
                            if (touchResponse.lineBarSpots!.first.barIndex == 0) {
                              // First line (FlDotCirclePainter)
                              int originalIndex = normalIndices[touchResponse.lineBarSpots!.first.spotIndex];
                              _selectedIndex = originalIndex;
                              _selectedIndex2 = null; // Reset the other index
                            } else if (touchResponse.lineBarSpots!.first.barIndex == 1) {
                              // Second line (CustomImagePainter)
                              int originalIndex = specialIndices[touchResponse.lineBarSpots!.first.spotIndex];
                              _selectedIndex2 = originalIndex;
                              _selectedIndex = null; // Reset the other index
                            }
                          });
                        } else {
                          setState(() {
                            _selectedIndex = null;
                            _selectedIndex2 = null;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDotPainter extends FlDotPainter {
  final double radius;
  final Color color;
  final Color strokeColor;
  final double strokeWidth;
  final String value;
  final String institute;
  final bool isSelected;

  CustomDotPainter({
    required this.radius,
    required this.color,
    required this.strokeColor,
    required this.strokeWidth,
    required this.value,
    required this.institute,
    required this.isSelected,
  });

  @override
  void draw(Canvas canvas, FlSpot spot, Offset offset) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Paint strokePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Draw the dot
    canvas.drawCircle(offset, radius, paint);
    canvas.drawCircle(offset, radius, strokePaint);

    // Draw the custom widget above the dot if selected

      final TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: 'I\nI\nI',
          style: TextStyle(color: Colors.black, fontSize: 12),
        ),
        textDirection: TextDirection.ltr,
      );
    final TextPainter textPainter2 = TextPainter(
      text: TextSpan(
        text: value,
        style: TextStyle(color: Colors.black, fontSize: 12),
      ),
      textDirection: TextDirection.ltr,
    );
      textPainter.layout();
    textPainter2.layout();

      final double textX = offset.dx - textPainter.width / 4;
      final double textY = offset.dy - radius - textPainter.height - 0;
    final double text2X = offset.dx - textPainter2.width / -3;
    final double text2Y = offset.dy - radius - textPainter2.height - 15;

      // Draw a background for the text
      final Paint backgroundPaint = Paint()..color = Colors.transparent;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(textX - 4, textY - 4, textPainter.width + 8, textPainter.height + 8),
          Radius.circular(4),
        ),
        backgroundPaint,
      );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(text2X - 4, text2Y - 4, textPainter2.width + 8, textPainter2.height + 8),
        Radius.circular(4),
      ),
      backgroundPaint,
    );
      // Draw the text
      textPainter.paint(canvas, Offset(textX, textY));
    textPainter2.paint(canvas, Offset(text2X, text2Y));

  }

  @override
  Size getSize(FlSpot spot) {
    // TODO: implement getSize
    throw UnimplementedError();
  }

  @override
  FlDotPainter lerp(FlDotPainter a, FlDotPainter b, double t) {
    // TODO: implement lerp
    throw UnimplementedError();
  }

  @override
  // TODO: implement mainColor
  Color get mainColor => throw UnimplementedError();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CustomImagePainter extends FlDotPainter {
  final ui.Image image;
  final bool isSelected; // Add this to track selection

  CustomImagePainter(this.image, {this.isSelected = false}); // Add isSelected parameter

  @override
  void draw(Canvas canvas, FlSpot spot, Offset offsetInCanvas) {
    final double imageSize = 20.0; // Adjust as needed
    final paint = Paint();

    // Draw the image
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      Rect.fromCenter(center: offsetInCanvas, width: imageSize, height: imageSize),
      paint,
    );

    // Draw a stroke around the image if selected
    if (isSelected) {
      final strokePaint = Paint()
        ..color = Colors.grey // Stroke color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0; // Stroke width
      canvas.drawCircle(offsetInCanvas, imageSize / 2 + 2, strokePaint); // Adjust radius as needed
    }
  }

  @override
  Size getSize(FlSpot spot) => const Size(20, 20); // Adjust size as needed

  FlDotPainter copyWith({ui.Image? newImage, bool? isSelected}) {
    return CustomImagePainter(
      newImage ?? image,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  FlDotPainter lerp(FlDotPainter a, FlDotPainter b, double t) {
    if (a is CustomImagePainter && b is CustomImagePainter) {
      return CustomImagePainter(
        b.image, // Use the image from the second painter
        isSelected: b.isSelected, // Use the selection state from the second painter
      );
    }
    return this;
  }

  @override
  Color get mainColor => Colors.transparent; // Not used for this custom painter

  @override
  List<Object?> get props => [image, isSelected]; // Include isSelected in props
}

class CustomIconDotPainter extends FlDotPainter {
  final IconData icon;
  final Color color;
  final bool isSelected;

  CustomIconDotPainter({
    required this.icon,
    required this.color,
    required this.isSelected,
  });

  @override
  void draw(Canvas canvas, FlSpot spot, Offset offsetInCanvas) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: 24,
          color: color,
          fontFamily: icon.fontFamily,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(offsetInCanvas.dx - textPainter.width / 2, offsetInCanvas.dy - textPainter.height / 2),
    );

    if (isSelected) {
      final Paint strokePaint = Paint()
        ..color = Colors.grey
        ..strokeWidth = 6
        ..style = PaintingStyle.stroke;

      canvas.drawCircle(offsetInCanvas, 12, strokePaint);
    }
  }

  @override
  Size getSize(FlSpot spot) {
    // TODO: implement getSize
    throw UnimplementedError();
  }

  @override
  FlDotPainter lerp(FlDotPainter a, FlDotPainter b, double t) {
    // TODO: implement lerp
    throw UnimplementedError();
  }

  @override
  // TODO: implement mainColor
  Color get mainColor => throw UnimplementedError();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

void main() {
  runApp(MaterialApp(home: GraphPage()));
}